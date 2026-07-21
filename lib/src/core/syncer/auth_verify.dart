import 'package:chat_shop/src/features/auth/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthVerify {
  final AuthCubit cubit;
  AuthVerify(this.cubit);
  Future<void> run() async {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        await cubit.verify();
      }
    });
  }
}
