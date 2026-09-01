import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';
import 'package:chat_shop/src/features/auth/domain/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpUser {
  final AuthRepository repo;
  SignUpUser(this.repo);
  Future <Result<User?>> call({required AuthDomain auth}) async {
    return repo.signUp(auth);
  }
}


 