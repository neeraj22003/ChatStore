import 'package:chat_shop/src/features/orders/domain/order_repo.dart';
import 'package:chat_shop/src/features/orders/domain/order_use_cases/delete_order.dart';
import 'package:chat_shop/src/features/orders/domain/order_use_cases/get_order_firstore.dart';
import 'package:chat_shop/src/features/orders/domain/order_use_cases/save_order_firestore.dart';

class OrderUsecases {
  final SaveOrder saveOrder;
  final GetOrder getOrder;
  final DeleteOrder deleteOrder;
  OrderUsecases(OrderRepo repo)
    : saveOrder = SaveOrder(repo),
      getOrder = GetOrder(repo),
      deleteOrder = DeleteOrder(repo);
}
