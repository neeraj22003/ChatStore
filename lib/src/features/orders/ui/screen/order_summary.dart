import 'package:chat_shop/src/core/widgets/counter_widget.dart';
import 'package:chat_shop/src/core/widgets/itembuilder.dart';
import 'package:chat_shop/src/features/cart/ui/widgets/cartitem.dart';
import 'package:chat_shop/src/features/cart/ui/widgets/normal_heading.dart';
import 'package:chat_shop/src/features/orders/bloc/order_bloc.dart';
import 'package:chat_shop/src/features/orders/bloc/order_events.dart';

import 'package:chat_shop/src/features/orders/ui/widgets/colored_bg.dart';
import 'package:chat_shop/src/features/orders/ui/widgets/delivery_detail.dart';
import 'package:chat_shop/src/features/orders/ui/widgets/summary_line.dart';
import 'package:chat_shop/src/injecters.dart';
import 'package:flutter/material.dart';
import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';

class OrderSummary extends StatelessWidget {
  final Orders orders;

  const OrderSummary({super.key, required this.orders});

  Widget summarItem() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Itembuilder(
        items: orders.items,
        mainaxisextent: 70,
        physics: NeverScrollableScrollPhysics(),
        mincount: 1,
        truncatedevidecountvalue: 300,
        itemBuilder: (context, item) {
          return Cartitem(
            trailing: CounterWidget(yourCountervalue: item.quantitynotfier),
            image: item.imageUrl,
            title: item.title,
            price: item.inrprice ?? 0.0,
            yourquantitynotfier: item.quantitynotfier,
          );
        },
      ),
    );
  }

  Widget ordersummarydetails(Color color) {
    final detail = [
      SummaryEntry(
        'Basket value',
        (double.tryParse(orders.total)! - 30).toStringAsFixed(1),
      ),
      SummaryEntry('Delivery charge', '30'),
      SummaryEntry(
        'Total pay',
        (double.tryParse(orders.total)!.toStringAsFixed(1)),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ColoredBg(
        radius: 16,
        color: color,
        child: SummaryLine(summaryEntry: detail),
      ),
    );
  }

  Widget deliverydetails(Color color) {
    final details = [
      DeliveryEntery(Icon(Icons.person, size: 16), orders.name, orders.address),
      DeliveryEntery(Icon(Icons.phone, size: 16), orders.phone, null),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ColoredBg(
        radius: 16,
        color: color,
        child: DeliveryDetail(detail: details, spacing: 8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const NormalHeading(yourheading: 'Order details'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              di<OrderBloc>().add(OrderDelete(orders.orderId));
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8),
              child: Divider(),
            ),
            summarItem(),
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8),
              child: Divider(),
            ),

            NormalHeading(yourheading: 'Order Summary'),
            ordersummarydetails(theme.surfaceContainer),
            NormalHeading(yourheading: 'Delivery address'),
            deliverydetails(theme.surfaceContainer),
          ],
        ),
      ),
    );
  }
}
