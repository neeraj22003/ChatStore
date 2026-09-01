import 'package:chat_shop/src/core/currency_service/currency_service.dart';
import 'package:chat_shop/src/core/items/data/ebay_service.dart';
import 'package:chat_shop/src/core/items/data/items_local_repoimpl.dart';
import 'package:chat_shop/src/core/items/data/items_localdb.dart';
import 'package:chat_shop/src/core/user/data/user_localdbimpl.dart';
import 'package:chat_shop/src/core/user/data/user_repository_impl.dart';
import 'package:chat_shop/src/core/user/data/user_store.dart';
import 'package:chat_shop/src/features/auth/data/auth_repository_impl.dart';
import 'package:chat_shop/src/features/auth/data/auth_service_impl.dart';

import 'package:chat_shop/src/features/cart/data/cart_repo_impl.dart';
import 'package:chat_shop/src/features/cart/data/location_service.dart';
import 'package:chat_shop/src/features/chat_history/data/chat_history_data.dart';
import 'package:chat_shop/src/features/chat_history/data/chat_history_repo_impl.dart';
import 'package:chat_shop/src/features/chats/data/chat_data_source.dart';
import 'package:chat_shop/src/features/chats/data/chat_repository.dart';
import 'package:chat_shop/src/features/orders/data/order_localdb.dart';
import 'package:chat_shop/src/features/orders/data/order_storeimpl.dart';
import 'package:chat_shop/src/features/orders/data/orders_repo_impl.dart';
import 'package:chat_shop/src/features/search/data/search_repo_impl.dart';
import 'package:chat_shop/src/features/search_users/data/search_user_repo.dart';
import 'package:chat_shop/src/features/search_users/data/search_user_service.dart';
import 'package:chat_shop/src/features/user_dashboard/data/google_auth_service.dart';
import 'package:chat_shop/src/features/user_dashboard/data/user_dashboard_repository_impl.dart';
import 'package:chat_shop/src/injecters.dart';

Future<void> repoDi() async {
  di.registerLazySingleton(
    () => UserRepositoryImpl(di<UserStoreImpl>(), di<UserLocaldbimpl>()),
  );
  di.registerLazySingleton(
    () => ItemsRepoimpl(
      di<ItemsLocaldb>(),
      di<EbuyService>(),
      di<CurrencyService>(),
    ),
  );
  di.registerLazySingleton(() => AuthRepositoryImpl(di<AuthServiceImpl>()));
  di.registerLazySingleton(() => CartRepoImpl(di<LocationService>()));
  di.registerLazySingleton(
    () => SearchRepoImpl(di<EbuyService>(), di<CurrencyService>()),
  );
  di.registerLazySingleton(() => SearchUserRepoImpl(di<SearchUserService>()));
  di.registerLazySingleton(
    () => UserDashboardRepositoryImpl(di<GoogleAuthservice>()),
  );
  di.registerLazySingleton(
    () => OrdersRepoImpl(di<OrderStoreimpl>(), di<OrderLocaldb>()),
  );
  di.registerLazySingleton(() => ChatRepoImpl(di<ChatDataSource>()));
  di.registerLazySingleton(() => ChatHistoryRepoImpl(di<ChatHistoryData>()));
}
