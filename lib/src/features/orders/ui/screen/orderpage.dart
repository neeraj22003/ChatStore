import 'package:chat_shop/src/core/assets/images.dart';
import 'package:chat_shop/src/core/widgets/itembuilder.dart';
import 'package:chat_shop/src/features/orders/bloc/order_bloc.dart';

import 'package:chat_shop/src/features/orders/bloc/order_states.dart';

import 'package:chat_shop/src/features/orders/ui/screen/order_summary.dart';
import 'package:chat_shop/src/features/orders/ui/widgets/order_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Orderpage extends StatelessWidget {
  const Orderpage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderStates>(
      builder: (context, state) {
        if (state is OrderError) {
          return Center(child: Text(state.error ?? 'error'));
        } else if (state is OrderLoading) {
          return Center(child: const CircularProgressIndicator());
        } else if (state is OrderLoaded) {
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Itembuilder(
              mincount: 1,
              items: state.orders,
              itemBuilder: (context, order) {
             
                return OrderCard(
                  
                  appname: 'Chat Shop',
                  appIconImg: ImageService.appImage,
                  images: order.items.map((data) => data.imageUrl).toList(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderSummary(orders: order),
                      ),
                    );
                  },
                );
              },
            ),
          );
        } else {
          return Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset(ImageService.noOrders, fit: BoxFit.cover),
            ),
          );
        }
      },
    );
  }
}
