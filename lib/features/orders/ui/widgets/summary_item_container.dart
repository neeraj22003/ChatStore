import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/orders/domain/orderdomain.dart';
import 'package:flutter_experiments/features/orders/ui/providers/order_provider.dart';
import 'package:flutter_experiments/features/search/data/search_dto.dart';

class SummaryItemContainer extends StatelessWidget {
  final Orders orders;

  const SummaryItemContainer({super.key, required this.orders});

  Widget title(EbuyItemsDetails item) {
    return Expanded(
      child: ListTile(
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),
        subtitle: Text(
          'Qnt:${item.quantity}',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        trailing: Text(
          '₹${item.inrprice * item.quantity}',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  Widget image(EbuyItemsDetails item) {
    return SizedBox(
      height: double.infinity,
      width: 70,
      child: ClipRRect(
        borderRadius: const BorderRadiusGeometry.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        child: Image.network(item.imageUrl ?? "", fit: BoxFit.cover),
      ),
    );
  }

  Widget card(EbuyItemsDetails item) {
    return Material(
      clipBehavior: Clip.hardEdge,

      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Row(children: [image(item), title(item)]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = orders.items.map((e) => EbuyItemsDetails.fromjson(e)).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final count = max(1, constraints.maxWidth ~/ 300);
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 250, minHeight: 80),
            child: SizedBox(
              height: 80,
              child: GridView.builder(
                scrollDirection: constraints.maxWidth < 227
                    ? Axis.horizontal
                    : Axis.vertical,
                padding: const EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  mainAxisExtent: constraints.maxWidth < 227 ? 200 : 70,

                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: item.length,
                itemBuilder: (context, i) {
                  return card(item[i]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
