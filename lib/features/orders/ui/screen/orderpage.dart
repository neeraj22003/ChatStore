import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_experiments/core/services/images.dart';
import 'package:flutter_experiments/features/orders/ui/widgets/order_card.dart';
import 'package:flutter_experiments/features/orders/ui/providers/order_provider.dart';
import 'package:provider/provider.dart';

class Orderpage extends StatelessWidget {
  const Orderpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, provider, child) {
        return provider.oders.isNotEmpty
            ? Ordertopitemcardlist(provider: provider)
            : Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(ImageService.noOrders, fit: BoxFit.cover),
                ),
              );
      },
    );
  }
}

class Ordertopitemcardlist extends StatelessWidget {
  final OrderProvider provider;
  const Ordertopitemcardlist({super.key, required this.provider});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrainst) {
        final count = max(1, constrainst.maxWidth ~/ 200);
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: provider.oders.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: provider.oders.length > 1 ? count : 1,
            mainAxisExtent: 160,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) =>
              OrderCard(order: provider.oders[index]),
        );
      },
    );
  }
}
