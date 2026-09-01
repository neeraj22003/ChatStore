import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';

abstract class OrderStates {}

class OrderInitial extends OrderStates {}

class OrderLoaded extends OrderStates {
  final List<Orders> orders;
  OrderLoaded(this.orders);
}

class OrderError extends OrderStates {
  final String? error;
  OrderError(this.error);
}

class OrderLoading extends OrderStates {}

class Onorderdeleted extends OrderStates {
  final List<Orders> orders;
  Onorderdeleted(this.orders);
}
