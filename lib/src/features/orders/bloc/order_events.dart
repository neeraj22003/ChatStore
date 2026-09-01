import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';

abstract class OrderEvents {}

class AddOrder extends OrderEvents {
  final Orders orders;
  AddOrder(this.orders);
}

class LoadOrder extends OrderEvents {}

class OrderDelete extends OrderEvents {
  final String orderid;
  OrderDelete(this.orderid);
}
