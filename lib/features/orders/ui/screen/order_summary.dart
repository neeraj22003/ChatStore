import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/orders/domain/orderdomain.dart';

import 'package:flutter_experiments/features/orders/ui/providers/order_provider.dart';
import 'package:flutter_experiments/features/orders/ui/widgets/summary_item_container.dart';
import 'package:provider/provider.dart';

class OrderSummary extends StatelessWidget {
  final Orders orders;

  const OrderSummary({super.key, required this.orders});

  Widget heading(String heading) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        heading,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget summaryrows(String text1, String text2, double widt) {
    final value = double.tryParse(text2) ?? 0.0;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: Row(
        children: [
          Text(text1, style: TextStyle(fontSize: widt < 220 ? 7 : 14)),
          Spacer(),
          Text(
            '₹${value.toStringAsFixed(1)}',
            style: TextStyle(fontSize: widt < 220 ? 7 : 12),
          ),
        ],
      ),
    );
  }

  Widget ordersummarydetails(double width) {
    final totalprice = double.tryParse(orders.total);
    return Column(
      children: [
        summaryrows('Basket value', '$totalprice', width),
        summaryrows('Delivery charge', '30', width),
        summaryrows('Total pay', '${(totalprice ?? 0.0) + 30}', width),
      ],
    );
  }

  Widget summarybox(double height, ColorScheme colo, List<Widget> widget) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: colo.surfaceContainerHigh,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(children: widget),
      ),
    );
  }

  Widget deliverydetails(
    double midwidth,
    Widget icon,
    String text1,
    String? text2,
    double width,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(padding: const EdgeInsets.only(top: 2), child: icon),
              SizedBox(width: midwidth),

              Expanded(
                child: text2 == null
                    ? Text(
                        text1,
                        style: TextStyle(fontSize: width < 200 ? 7 : 15),
                      )
                    : ListTile(
                        title: Text(
                          text1,
                          style: TextStyle(fontSize: width < 200 ? 7 : 15),
                        ),
                        subtitle: Text(
                          text2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontSize: width < 200 ? 7 : 15),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Consumer<OrderProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Order details', style: TextStyle(fontSize: 20)),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  provider.deleteorder(orders.orderId);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraint) {
              final width = constraint.maxWidth;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: theme.outlineVariant, thickness: 1.5),
                    SummaryItemContainer(orders: orders),
                    Divider(color: theme.outlineVariant, thickness: 1.5),
                    heading('Order Summary'),
                    summarybox(100, theme, [ordersummarydetails(width)]),
                    heading('Delivery address'),
                    summarybox(150, theme, [
                      deliverydetails(
                        8,
                        Icon(Icons.person, size: 16),
                        orders.name,
                        orders.address,
                        width,
                      ),
                      deliverydetails(
                        22,
                        Icon(Icons.phone, size: 16),
                        orders.phone,
                        null,
                        width,
                      ),
                    ]),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
