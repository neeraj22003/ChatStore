import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';

abstract class OrderStore {
  Future<Result<String>> saveOrder(Orders orders);
  Future<Result<List<Orders>>> getOrder();
  Future<Result<bool>> deleteOrder(String orderid);
}
