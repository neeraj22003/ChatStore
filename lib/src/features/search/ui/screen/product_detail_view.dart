import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:chat_shop/src/features/cart/cubit/cart_cubit.dart';
import 'package:chat_shop/src/features/search/bloc/detail_cubit/detail_cubit.dart';
import 'package:chat_shop/src/features/search/bloc/detail_cubit/detail_state.dart';
import 'package:chat_shop/src/core/widgets/counter_widget.dart';
import 'package:chat_shop/src/features/search/ui/widgets/bottomsheet/description_widget.dart';

import 'package:chat_shop/src/features/search/ui/widgets/bottomsheet/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final ValueNotifier<bool> isexpaned = ValueNotifier(false);

  Widget _image(String image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(image)),
        ),
      ),
    );
  }

  Widget _description(String description) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DescriptionWidget(
        onpressed: () =>
            isexpaned.value = isexpaned.value == true ? false : true,
        description: description,
        isExpanded: isexpaned,
      ),
    );
  }

  Widget _counterWidget(SearchDomain item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CounterWidget(
        onIncrement: () {
          item.quantitynotfier.value++;
          context.read<DetailCubit>().updatequantity(
            item.itemId,
            item.quantitynotfier.value,
          );
        },
        yourCountervalue: item.quantitynotfier,
        onDecrement: () {
          if (item.quantitynotfier.value > 1) {
            item.quantitynotfier.value--;
            context.read<DetailCubit>().updatequantity(
              item.itemId,
              item.quantitynotfier.value,
            );
          }
        },
        trailing: OutlinedButton(
          onPressed: () async {
            context.read<DetailCubit>().startloading();
            await context.read<CartCubit>().additemToCart(item);
            if (mounted) {
              Navigator.of(context).pop();
            }
          },
          child: Text('Add to Cart'),
        ),
      ),
    );
  }

  Widget _details(SearchDomain data) {
    return SingleChildScrollView(
      child: Wrap(
        children: [
          TitleWidget(title: data.title),
          _description(data.description!),
          _image(data.imageUrl),
          _counterWidget(data),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailCubit, DetailState>(
      builder: (context, state) {
        if (state is IsDetailsLoading) {
          return Wrap(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        } else if (state is IsDetailsError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(state.error ?? ''),
          );
        } else if (state is IsDetailsLoded) {
          
          return _details(state.details);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
