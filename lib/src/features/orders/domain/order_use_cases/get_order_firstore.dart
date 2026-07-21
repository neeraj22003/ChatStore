
import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/orders/domain/order_repo.dart';
import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';

class GetOrder {
  final OrderRepo repo;
  GetOrder(this.repo);
  Future<Result<List<Orders>>> call() async {
    return await repo.getOrders();
  }
}
