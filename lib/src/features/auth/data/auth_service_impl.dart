import 'dart:async';

import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';
import 'package:chat_shop/src/features/auth/domain/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceImpl implements AuthService {
  final FirebaseAuth auth;
  AuthServiceImpl(this.auth);
  @override
  Future<Result<bool>> cancelverification() async {
    final user = auth.currentUser;
    try {
      if (user != null && !user.emailVerified) {
        await user.delete();
        return Result.onSuccess(true);
      } else {
        return Result.onfailure('no user exist');
      }
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }



  @override
  Future<Result<bool>> logout() async {
    try {
      await auth.signOut();
      return Result.onSuccess(true);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  @override
  Future<Result<User?>> signIn(AuthDomain user) async {
    try {
      final signin = await auth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
       await Future.delayed(const Duration(seconds: 2));
      if (signin.user != null) {
        await signin.user?.reload();
        
        final freshuser = FirebaseAuth.instance.currentUser;
        
        if (freshuser != null&&freshuser.emailVerified) {
          return Result.onSuccess(freshuser);
        }
        return Result.onSuccess(null);
      } else {
        return Result.onfailure('No User');
      }
    } catch (e) {
      return Result.onfailure('Error ${e.toString()}');
    }
  }

  @override
  Future<Result<User?>> signUp(AuthDomain user) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      await Future.delayed(const Duration(seconds: 1));
      final freshuser = FirebaseAuth.instance.currentUser;
      if (freshuser != null) {
        return Result.onSuccess(freshuser);
      } else {
        return Result.onfailure('Something went wrong');
      }
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  @override
  Future<Result<bool>> verify() async {
    try {
      

      await auth.currentUser?.reload();
      final freshuser = FirebaseAuth.instance.currentUser;
      if (freshuser != null && freshuser.emailVerified) {
        return Result.onSuccess(true);
      }
      auth.currentUser?.sendEmailVerification();

      int attempt = 0;
      int totalattempt = 15;
      while (totalattempt > attempt) {
        await Future.delayed(const Duration(seconds: 4));
        await auth.currentUser?.reload();
        final freshuser = FirebaseAuth.instance.currentUser;
        if (freshuser != null && freshuser.emailVerified) {
          return Result.onSuccess(true);
        }
        attempt++;
      }

      return Result.onfailure('timedout');
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }
}
