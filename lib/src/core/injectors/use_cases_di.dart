import 'package:chat_shop/src/core/items/data/items_local_repoimpl.dart';
import 'package:chat_shop/src/core/items/domain/usecases/usecases_bundle/item_use_cases.dart';
import 'package:chat_shop/src/core/user/data/user_repository_impl.dart';
import 'package:chat_shop/src/core/user/domain/user_usecases/user_usecase.dart';
import 'package:chat_shop/src/features/auth/data/auth_repository_impl.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/usecases_bundle/use_cases_bundle.dart';
import 'package:chat_shop/src/features/cart/data/cart_repo_impl.dart';
import 'package:chat_shop/src/features/cart/domain/cart_usecases.dart';
import 'package:chat_shop/src/features/chat_history/data/chat_history_repo_impl.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_use_cases/use_cases.dart';
import 'package:chat_shop/src/features/chats/data/chat_repository.dart';
import 'package:chat_shop/src/features/chats/domain/use_cases/chat_usecase/chat_use_cases.dart';
import 'package:chat_shop/src/features/orders/data/orders_repo_impl.dart';
import 'package:chat_shop/src/features/orders/domain/order_use_cases/use_case_bundle/use_case_bundle.dart';
import 'package:chat_shop/src/features/search/data/search_repo_impl.dart';
import 'package:chat_shop/src/features/search/domain/search_usecases.dart/search_usecases.dart';
import 'package:chat_shop/src/features/search_users/data/search_user_repo.dart';
import 'package:chat_shop/src/features/search_users/domain/use_cases/use_case_bundle/use_case_bundle.dart';
import 'package:chat_shop/src/features/user_dashboard/data/user_dashboard_repository_impl.dart';
import 'package:chat_shop/src/features/user_dashboard/domain/use_cases/use_cases.dart';
import 'package:chat_shop/src/injecters.dart';

Future<void> useCasesdi() async {
  di.registerFactory(() => ItemUseCases(di<ItemsRepoimpl>()));
  di.registerFactory(() => UserUsecase(di<UserRepositoryImpl>()));
  di.registerFactory(() => AuthUseCases(di<AuthRepositoryImpl>()));
  di.registerFactory(() => CartUsecases(di<CartRepoImpl>()));
  di.registerFactory(() => OrderUsecases(di<OrdersRepoImpl>()));
  di.registerFactory(() => SearchUsecases(di<SearchRepoImpl>()));
  di.registerFactory(
    () => UserdashboardUseCases(di<UserDashboardRepositoryImpl>()),
  );
  di.registerFactory(() => SearchuserUseCase(di<SearchUserRepoImpl>()));
  di.registerFactory(() => ChatUseCases(di<ChatRepoImpl>()));
  di.registerFactory(() => ChathistoryUseCases(di<ChatHistoryRepoImpl>()));
}
