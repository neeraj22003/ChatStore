import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/orders/data/order_localdb.dart';
import 'package:chat_shop/src/features/orders/domain/order_repo.dart';
import 'package:chat_shop/src/features/orders/domain/order_store.dart';
import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';

class OrdersRepoImpl implements OrderRepo {
  final OrderStore orderStore;
  final OrderLocaldb orderLocaldb;
  OrdersRepoImpl(this.orderStore, this.orderLocaldb);

  Map<String, Orders> _cache = {};

  @override
  Future<Result<String>> saveOrder(Orders order) async {
    final entry = {};
    entry[order.orderId] = order;
    _cache = {...entry, ..._cache};
    final result = await Future.wait([
      orderStore.saveOrder(order),
      orderLocaldb.saveOrder(order),
    ]);
    final fire = result[0];
    final sqlite = result[1];
    if (fire.isFailure && sqlite.isFailure) {
      return Result.onfailure('${fire.error},${sqlite.error}');
    }
    if (fire.isFailure) {
      return Result.onfailure(fire.error);
    }
    if (sqlite.isFailure) {
      return Result.onfailure(sqlite.error);
    }

    return Result.onSuccess('${fire.data},${sqlite.data}');
  }

  @override
  void loadOrders(List<Orders> orders) {
    print(orders.length);
    for (var i in orders) {
      _cache[i.orderId] = i;
    }
  }

  @override
  Future<Result<List<Orders>>> getOrders() async {
    if (_cache.isNotEmpty) {
      return Result.onSuccess(_cache.values.toList());
    }
    final localdb = await orderLocaldb.getOrder();
    if (localdb.isSuccess) {
      
      loadOrders(localdb.data!);
      return Result.onSuccess(_cache.values.toList());
    }
    final firestore = await orderStore.getOrder();
    if (firestore.isSuccess) {
      loadOrders(firestore.data!);
      return Result.onSuccess(_cache.values.toList());
    }
    return Result.onfailure('${localdb.error},${firestore.error}');
  }

  @override
  Future<Result<bool>> deleteOrder(String orderid) async {
    _cache.remove(orderid);
    final result = await Future.wait([
      orderLocaldb.deleteOrder(orderid),
      orderStore.deleteOrder(orderid),
    ]);
    final fire = result[1];
    final sqlite = result[0];
    if (sqlite.isFailure && fire.isFailure) {
      return Result.onfailure('${fire.error}${fire.error}');
    }
    if (sqlite.isFailure) {
      return Result.onfailure(sqlite.error);
    }
    if (fire.isFailure) {
      return Result.onfailure(fire.error);
    }
    return Result.onSuccess(true);
  }
}
