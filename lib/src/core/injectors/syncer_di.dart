import 'package:chat_shop/src/core/items/domain/usecases/usecases_bundle/item_use_cases.dart';
import 'package:chat_shop/src/core/syncer/auth_verify.dart';
import 'package:chat_shop/src/core/syncer/item_syncer.dart';
import 'package:chat_shop/src/features/auth/cubit/auth_cubit.dart';
import 'package:chat_shop/src/features/cart/cubit/cart_cubit.dart';
import 'package:chat_shop/src/features/orders/bloc/order_bloc.dart';
import 'package:chat_shop/src/features/user_dashboard/cubit/user_cubit.dart';
import 'package:chat_shop/src/injecters.dart';

Future<void> syncerDi() async {
  di.registerLazySingleton(
    () => ItemSyncer(
      di<ItemUseCases>(),
      di<CartCubit>(),
      di<OrderBloc>(),
      di<UserDashboardCubit>(),
    ),
  );
 
  di.registerLazySingleton(() => AuthVerify(di<AuthCubit>()));
}
