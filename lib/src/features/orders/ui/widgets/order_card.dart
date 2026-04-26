import 'package:flutter/material.dart';
import 'package:chat_shop/src/core/services/images.dart';
import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';

import 'package:chat_shop/src/features/orders/ui/screen/order_summary.dart';
import 'package:chat_shop/src/features/search/data/search_dto.dart';

class OrderCard extends StatelessWidget {
  final Orders order;

  const OrderCard({super.key, required this.order});

  Widget brandheader() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Image.asset(ImageService.appImage),
          ),
          const SizedBox(width: 5),
          Text(
            'Store',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget imagelist(ColorScheme color) {
    final item = order.items.map((e) => EbuyItemsDetails.fromjson(e)).toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: color.surfaceContainerHighest,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: order.items.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              child: Image.network(item[i].imageUrl ?? '', fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }

  Widget button(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderSummary(orders: order),
            ),
          );
        },
        icon: const Icon(Icons.arrow_circle_right_outlined, size: 35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      color: theme.surfaceContainer,
      child: Column(
        children: [brandheader(), imagelist(theme), button(context)],
      ),
    );
  }
}
