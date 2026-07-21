import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Result<User?>> login(AuthDomain auth);
  Future<Result<User?>> signUp(AuthDomain auth);
  Future<Result<bool>> cancelverification();
  Future<Result<bool>> verify();

  Future<Result<bool>> logout();
}
