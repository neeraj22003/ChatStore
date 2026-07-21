import 'package:chat_shop/src/core/items/domain/usecases/usecases_bundle/item_use_cases.dart';
import 'package:chat_shop/src/features/cart/cubit/cart_cubit.dart';
import 'package:chat_shop/src/features/orders/bloc/order_bloc.dart';
import 'package:chat_shop/src/features/orders/bloc/order_events.dart';
import 'package:chat_shop/src/features/user_dashboard/cubit/user_cubit.dart';

class ItemSyncer {
  final ItemUseCases useCases;
  final CartCubit cartCubit;
  final OrderBloc orderBloc;
  final UserDashboardCubit userDashboardCubit;
  ItemSyncer(
    this.useCases,
    this.cartCubit,
    this.orderBloc,
    this.userDashboardCubit,
  );

  Future<void> run() async {
    final items = await useCases.loadItem.call();

    cartCubit.loaditem(items);
    orderBloc.add(LoadOrder());
    await userDashboardCubit.getUser();
  }
}
