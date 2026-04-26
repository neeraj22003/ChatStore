import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:chat_shop/src/features/orders/ui/providers/order_provider.dart';

import 'package:provider/provider.dart';
import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';

class OrdersRepositry {
  Future<void> addOrders(
    Orders order,
    String? userId,

    BuildContext context,
  ) async {
    final doc = await FirebaseFirestore.instance
        .collection('orders')
        .doc(userId)
        .collection('userorders')
        .add(order.toJson());
    final localorders = Orders(
      orderId: doc.id,
      name: order.name,
      phone: order.phone,
      address: order.address,
      total: order.total,
      items: order.items,
    );
    if (context.mounted) {
      Provider.of<OrderProvider>(context, listen: false).addoder(localorders);
    }
    final cartdoc = await FirebaseFirestore.instance
        .collection('cart')
        .doc(userId)
        .collection('items')
        .get();
    for (var doc in cartdoc.docs) {
      if (doc.data().isNotEmpty) {
        doc.reference.delete();
      }
    }
  }

  Future<List<Orders>> getOrder(String userId) async {
    final orders = await FirebaseFirestore.instance
        .collection('orders')
        .doc(userId)
        .collection('userorders')
        .orderBy('createdAT', descending: true)
        .get();
    return orders.docs.map((data) {
      return Orders.fromdoc(data);
    }).toList();
  }
}
