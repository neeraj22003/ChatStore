import 'package:chat_shop/src/core/items/domain/usecases/usecases_bundle/item_use_cases.dart';
import 'package:chat_shop/src/core/layout/bloc/end_drawer_bloc.dart';
import 'package:chat_shop/src/core/user/domain/user_usecases/user_usecase.dart';
import 'package:chat_shop/src/features/auth/cubit/auth_cubit.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/usecases_bundle/use_cases_bundle.dart';
import 'package:chat_shop/src/features/cart/cubit/cart_cubit.dart';
import 'package:chat_shop/src/features/cart/domain/cart_usecases.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_bloc.dart';
import 'package:chat_shop/src/features/chats/domain/use_cases/chat_usecase/chat_use_cases.dart';
import 'package:chat_shop/src/features/orders/bloc/order_bloc.dart';
import 'package:chat_shop/src/features/orders/domain/order_use_cases/use_case_bundle/use_case_bundle.dart';
import 'package:chat_shop/src/features/search/bloc/detail_cubit/detail_cubit.dart';
import 'package:chat_shop/src/features/search/bloc/searc_bloc/search_bloc.dart';
import 'package:chat_shop/src/features/search/bloc/searc_bloc/search_event.dart';
import 'package:chat_shop/src/features/search/domain/search_usecases.dart/search_usecases.dart';
import 'package:chat_shop/src/features/search_users/bloc/search_user_block.dart';

import 'package:chat_shop/src/features/search_users/domain/use_cases/use_case_bundle/use_case_bundle.dart';
import 'package:chat_shop/src/features/user_dashboard/cubit/user_cubit.dart';
import 'package:chat_shop/src/features/user_dashboard/domain/use_cases/use_cases.dart';
import 'package:chat_shop/src/injecters.dart';


Future<void> cubitBlocDi() async {
  di.registerLazySingleton(() => AuthCubit(di<AuthUseCases>(), di<UserUsecase>()));
  di.registerLazySingleton(
    () => CartCubit(di<ItemUseCases>(),  di<CartUsecases>()),
  );
  di.registerLazySingleton(() => OrderBloc(di<OrderUsecases>()));
  di.registerFactory(() {
    final bloc = SearchBloc(di<SearchUsecases>());
    bloc.add(OnloadDailyDeals());
    return bloc;
  });
  di.registerFactory(() => DetailCubit(di<ItemUseCases>()));
  di.registerLazySingleton(() => SearchUserBloc(di<SearchuserUseCase>(),di<UserUsecase>()));
  di.registerLazySingleton(() => UserDashboardCubit(di<UserUsecase>(), di<UserdashboardUseCases>()));
  di.registerFactory(() => EndDrawerBloc(di<ItemUseCases>(),di<UserUsecase>()));
  di.registerFactory(()=>ChatBloc(di<ChatUseCases>(), di<UserUsecase>()));
}
