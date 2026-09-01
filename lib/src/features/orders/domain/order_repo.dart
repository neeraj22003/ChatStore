import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';

abstract class OrderRepo {
  Future<Result<String>> saveOrder(Orders order);
  void loadOrders(List<Orders> order);
  Future<Result<List<Orders>>> getOrders();
  Future<Result<bool>> deleteOrder(String orderid);
}
