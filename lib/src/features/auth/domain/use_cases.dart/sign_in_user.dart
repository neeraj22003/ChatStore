import 'package:chat_shop/src/core/result/result_domain.dart';

import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';
import 'package:chat_shop/src/features/auth/domain/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInUser {
  final AuthRepository repo;
  SignInUser(this.repo);
  Future<Result<User?>> call(AuthDomain auth) async {
    return await repo.login(auth);
  }
}
