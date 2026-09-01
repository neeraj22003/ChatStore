import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/orders/data/order_dto.dart';
import 'package:chat_shop/src/features/orders/domain/order_store.dart';
import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderStoreimpl implements OrderStore {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  OrderStoreimpl(this.firestore, this.auth);
  @override
  Future<Result<List<Orders>>> getOrder() async {
    try {
      final result = await firestore
          .collection('orders')
          .doc(auth.currentUser?.uid)
          .collection('userorders')
          .orderBy('createdAT', descending: true)
          .get();
      if (result.docs.isNotEmpty) {
        final order = result.docs
            .map((data) => OrdersDto.fromdoc(data).toDomain())
            .toList();
        return Result.onSuccess(order);
      } else {
        return Result.onSuccess([]);
      }
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  @override
  Future<Result<String>> saveOrder(Orders order) async {
    try {
      final orderdto = OrdersDto(
        orderId: order.orderId,
        name: order.name,
        phone: order.phone,
        address: order.address,
        total: order.total,
        items: order.items,
      );
      final result = await firestore
          .collection('orders')
          .doc(auth.currentUser?.uid)
          .collection('userorders')
          .add(orderdto.toFireJson());
      return Result.onSuccess(result.id);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }
  @override
  Future<Result<bool>> deleteOrder(String orderid) async {
    try {
      final result = await firestore
          .collection('orders')
          .doc(auth.currentUser?.uid)
          .collection('userorders')
          .where('orderid', isEqualTo: orderid)
          .get();
      for (var i in result.docs) {
        i.reference.delete();
      }
      return Result.onSuccess(true);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }
}
