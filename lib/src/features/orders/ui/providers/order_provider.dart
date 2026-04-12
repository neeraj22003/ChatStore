import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/orders/data/orders_repositry.dart';
import 'package:flutter_experiments/features/orders/domain/orderdomain.dart';

class OrderProvider extends ChangeNotifier {
  List<Orders> _orders = [];
  List<Orders> get oders => _orders;
  final userid = FirebaseAuth.instance.currentUser!.uid;

  OrderProvider() {
    getorder();
  }

  void addoder(Orders order) {
    _orders = [order, ..._orders];
    notifyListeners();
  }

  void getorder() async {
    final orders = await OrdersRepositry().getOrder(userid);
    _orders = orders;

    notifyListeners();
  }

  void deleteorder(String? orderid) async {
    if (orderid == null) return;
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(userid)
        .collection('userorders')
        .doc(orderid)
        .delete();
    _orders.removeWhere((element) => element.orderId == orderid);
    notifyListeners();
  }
}
