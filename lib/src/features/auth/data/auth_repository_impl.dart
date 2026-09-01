import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';
import 'package:chat_shop/src/features/auth/domain/auth_repo.dart';
import 'package:chat_shop/src/features/auth/domain/auth_service.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _auth;

  AuthRepositoryImpl(this._auth);

  @override
  Future<Result<User?>> login(AuthDomain user) async {
    final result = await _auth.signIn(user);
    if (result.isFailure) {
      return Result.onfailure(result.error);
    }

    return Result.onSuccess(result.data!);
  }

  @override
  Future<Result<User?>> signUp(AuthDomain auth) async {
    final result = await _auth.signUp(auth);
    if (result.isFailure) {
      return Result.onfailure(result.error);
    }

    return Result.onSuccess(result.data);
  }

  @override
  Future<Result<bool>> logout() async {
    final result = await _auth.logout();
    if (result.isFailure) {
      return Result.onfailure(result.error);
    }

    return Result.onSuccess(result.data!);
  }

  @override
  Future<Result<bool>> cancelverification() async {
    final result = await _auth.cancelverification();
    if (result.isSuccess) {
      return Result.onSuccess(true);
    }

    return Result.onfailure(result.error);
  }

  @override
  Future<Result<bool>> verify() async {
    final result = await _auth.verify();
    if (result.isFailure) {
      print('error');
      return Result.onfailure(result.error);
    }

    return Result.onSuccess(result.data ?? true);
  }
}
