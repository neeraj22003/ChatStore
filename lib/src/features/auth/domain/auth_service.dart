import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<Result<User?>> signIn(AuthDomain auth);
  Future <Result<bool>> verify();
  Future<Result<User?>> signUp(AuthDomain auth);
  Future<Result<bool>> logout();
  Future<Result<bool>> cancelverification();
}
