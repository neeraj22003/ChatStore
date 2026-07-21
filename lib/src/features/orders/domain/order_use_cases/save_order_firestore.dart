
import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/orders/domain/order_repo.dart';
import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';

class SaveOrder {
  final OrderRepo repo;
  SaveOrder(this.repo);
  Future<Result<String>> call(Orders order) async {
    return await repo.saveOrder(order);
  }
}
