import 'package:chat_shop/src/core/layout/notfiers/notifiers.dart';
import 'package:chat_shop/src/features/chat_history/notifiers/notifiers.dart';
import 'package:chat_shop/src/injecters.dart';

Future<void> initNotifier() async {
  di.registerLazySingleton(() => Not());
  di.registerLazySingleton(() => ChatNotifiers());
}
