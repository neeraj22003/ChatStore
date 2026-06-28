import 'package:chat_shop/src/core/domain/result_domain.dart';
import 'package:chat_shop/src/features/auth/data/auth_repository.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpUser {
  final AuthRepository repo;
  SignUpUser(this.repo);
  Future <Result<User?>> call({required AuthDomain auth}) async {
    return repo.signUp(auth);
  }
}


 