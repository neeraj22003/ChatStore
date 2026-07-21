import 'package:chat_shop/src/features/orders/bloc/order_events.dart';
import 'package:chat_shop/src/features/orders/bloc/order_states.dart';
import 'package:chat_shop/src/features/orders/domain/order_use_cases/use_case_bundle/use_case_bundle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvents, OrderStates> {
  final OrderUsecases orderUsecases;
  OrderBloc(this.orderUsecases) : super(OrderInitial()) {
    on<AddOrder>((event, emit) async {
      final result = await orderUsecases.saveOrder.call(event.orders);
      if (result.isFailure) {
        emit(OrderError(result.error));
      }
      final order = await orderUsecases.getOrder.call();
      if (order.isFailure) {
        emit(OrderError(order.error));
      }
      if (order.isSuccess) {
        emit(OrderLoaded(order.data!));
      }
    });

    on<LoadOrder>((event, emit) async {
      final result = await orderUsecases.getOrder.call();
      if (result.isFailure) {
        emit(OrderError(result.error));
      }
      if (result.isSuccess) {
        if (result.data!.isEmpty) {
          emit(OrderInitial());
        } else {
          emit(OrderLoaded(result.data!));
        }
      }
    });

    on<OrderDelete>((event, emit) async {
      final result = await orderUsecases.deleteOrder.call(event.orderid);
      if (result.isFailure) {
        emit(OrderError(result.error));
      }
      if (result.isSuccess) {
        final reshedlist = await orderUsecases.getOrder.call();
        if (reshedlist.data!.isEmpty) {
          emit(OrderInitial());
        } else {
          emit(OrderLoaded(reshedlist.data!));
        }
      }
    });
  }
}
