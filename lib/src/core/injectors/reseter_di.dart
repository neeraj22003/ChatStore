import 'package:chat_shop/src/core/all_state_reseter/reseter.dart';
import 'package:chat_shop/src/injecters.dart';

Future<void> reseterdi() async {
  di.registerLazySingleton(() => Reseter());
}
