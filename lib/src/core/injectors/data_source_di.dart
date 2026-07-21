import 'package:chat_shop/src/core/currency_service/currency_service.dart';
import 'package:chat_shop/src/core/items/data/ebay_service.dart';
import 'package:chat_shop/src/core/items/data/items_localdb.dart';
import 'package:chat_shop/src/core/user/data/user_localdbimpl.dart';
import 'package:chat_shop/src/core/user/data/user_store.dart';
import 'package:chat_shop/src/features/auth/data/auth_service_impl.dart';

import 'package:chat_shop/src/features/cart/data/location_service.dart';
import 'package:chat_shop/src/features/chats/data/chat_data_source.dart';
import 'package:chat_shop/src/features/orders/data/order_localdb.dart';
import 'package:chat_shop/src/features/orders/data/order_storeimpl.dart';
import 'package:chat_shop/src/features/search_users/data/search_user_service.dart';
import 'package:chat_shop/src/features/user_dashboard/data/google_auth_service.dart';
import 'package:chat_shop/src/injecters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> dataSourceDi() async {
  di.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  di.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  di.registerFactory(
    () => UserStoreImpl(di<FirebaseFirestore>(), di<FirebaseAuth>()),
  );
  di.registerFactory(() => AuthServiceImpl(di<FirebaseAuth>()));
  di.registerFactory(() => ItemsLocaldb());
  di.registerFactory(() => EbuyService());
  di.registerFactory(() => UserLocaldbimpl(di<FirebaseAuth>().currentUser));
  di.registerFactory(() => LocationService());
  di.registerLazySingleton(() => OrderLocaldb());
  di.registerFactory(() => GoogleAuthservice());
  di.registerSingletonAsync<CurrencyService>(() async {
    final service = CurrencyService();
    await service.init();
    return service;
  });
  di.registerFactory(() => SearchUserService());
  di.registerFactory(
    () => OrderStoreimpl(di<FirebaseFirestore>(), di<FirebaseAuth>()),
  );
  di.registerFactory(() => ChatDataSource(di<FirebaseFirestore>()));
}
