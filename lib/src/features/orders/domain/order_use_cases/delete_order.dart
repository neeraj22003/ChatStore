import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/orders/domain/order_repo.dart';

class DeleteOrder {
  final OrderRepo repo;
  DeleteOrder(this.repo);
  Future<Result<bool>> call(String orderid) async {
    return await repo.deleteOrder(orderid);
  }
}
