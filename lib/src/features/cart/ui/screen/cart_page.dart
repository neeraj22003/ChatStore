import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/core/widgets/counter_widget.dart';

import 'package:chat_shop/src/features/cart/cubit/cart_cubit.dart';
import 'package:chat_shop/src/features/cart/cubit/cart_state.dart';
import 'package:chat_shop/src/features/cart/ui/widgets/bottom_sheet.dart';
import 'package:chat_shop/src/features/cart/ui/widgets/cartitem.dart';
import 'package:chat_shop/src/features/cart/ui/widgets/custom_list.dart';
import 'package:chat_shop/src/features/cart/ui/widgets/divider.dart';
import 'package:chat_shop/src/features/cart/ui/widgets/dropdown_widget.dart';
import 'package:chat_shop/src/features/cart/ui/widgets/normal_heading.dart';

import 'package:chat_shop/src/features/cart/ui/widgets/total_cart.dart';
import 'package:chat_shop/src/features/cart/ui/widgets/total_cost_widget.dart';
import 'package:chat_shop/src/core/widgets/outlined_button.dart';
import 'package:chat_shop/src/features/orders/bloc/order_bloc.dart';
import 'package:chat_shop/src/features/orders/bloc/order_events.dart';
import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';
import 'package:chat_shop/src/injecters.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CartPage extends StatefulWidget {
  final int cartlength;
  final UserDomain user;
  const CartPage({super.key, required this.cartlength, required this.user});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final ValueNotifier<int> totalcartquantity = ValueNotifier(
    widget.cartlength,
  );
  final ValueNotifier<double> totalcost = ValueNotifier(0);
  final ValueNotifier<String?> locationnotifier = ValueNotifier(null);
  final ValueNotifier<bool> isloading = ValueNotifier(false);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late String selectedLoaction = widget.user.address;
  Widget listofitem(List<SearchDomain> items) {
    final cubit = context.read<CartCubit>();

    return CustomList(
      itemlength: items.length,
      itemnotifier: totalcartquantity,
      itemBuilder: (context, index) {
        final data = items[index];
        return Cartitem(
          key: ValueKey(data.itemId),
          image: data.imageUrl,
          title: data.title,
          price: data.inrprice ?? 0,
          yourquantitynotfier: data.quantitynotfier,
          trailing: _counter(data, cubit),
        );
      },
    );
  }

  Widget _counter(SearchDomain data, CartCubit cubit) {
    return SizedBox(
      width: 100,
      child: FittedBox(
        child: CounterWidget(
          size: 25,
          onIncrement: () {
            cubit.onIncrement(data);
            totalcost.value = cubit.totalcost();
          },
          yourCountervalue: data.quantitynotfier,
          onDecrement: () async {
            cubit.onDecrement(data);

            totalcost.value = cubit.totalcost();
            totalcartquantity.value = cubit.getcurrentItemlength();
            if (context.mounted && cubit.getcurrentItemlength() < 1) {
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }

  Widget _totalcartquant() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TotalCart(yourcartlength: totalcartquantity),
    );
  }

  Widget _totalRow(double cost) {
    totalcost.value = cost;
    return Row(
      children: [
        _totalcartquant(),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TotalCostWidget(
              totalcost: totalcost,
              textsize: 13,
              costsize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdown() {
    return Form(
      key: _key,
      child: DropdownWidget(
        isloading: isloading,
        yourDefaultvalue: widget.user.address,
        yourdefaultlabel: widget.user.address,
        onTaponCurrentlocation: locationnotifier,
        onSelected: (value) async {
          final selected = await context.read<CartCubit>().getlocation(
            value,
            isloading,
            locationnotifier,
          );
          selectedLoaction = selected ?? '';

          if (_key.currentState!.validate()) {}
        },
      ),
    );
  }

  Widget _placebuttom(List<SearchDomain> items) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Customoutlinebutton(
        height: 40,
        width: double.infinity,
        borderradius: 12,
        fontsize: 16,
        onPressed: () {
          final uid = Uuid();
          final orders = Orders(
            name: widget.user.name,
            address: selectedLoaction,
            phone: widget.user.phone,
            orderId: uid.v4(),
            total: totalcost.value.toString(),
            items: items,
          );
          di<OrderBloc>().add(AddOrder(orders));
          context.read<CartCubit>().clearCart();
          Navigator.of(context).pop();
        },

        text: 'Place Order',
        color: const Color(0xFF1B5E20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is Cartloading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Cartloaded) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            body: Column(
              crossAxisAlignment: .start,
              children: [
                NormalHeading(yourheading: 'Shopping Cart'),
                _dropdown(),
                CustomDivider(),
                listofitem(state.item),
                CustomDivider(),
              ],
            ),

            bottomSheet: CartBottomSheet(
              children: [
                _totalRow(state.totalcost),

                CustomDivider(),
                _placebuttom(state.item),
              ],
            ),
          );
        } else if (state is CartError) {
          return Text(state.error ?? 'some thing Went wrong');
        } else {
          return Center(child: Text('No Item yet'));
        }
      },
    );
  }
}
