

import 'package:chat_shop/src/core/domain/result_domain.dart';
import 'package:chat_shop/src/features/auth/data/local_auth_prefrence.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Result<User?>> login(AuthDomain auth);
  Future<Result<User?>> signUp(AuthDomain auth);
  Future<Result<void>> cancelverification();
  Future<void> saveUser(AuthDomain user);
  Result<Stream<User?>> userAuthStates();
  Future<Result<User?>> checkEmailverfication(User? user);
  Future<void> logout();
  Future<Result<AuthDomain?>> getUser();
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;
  final LocalAuthPrefrence local;
  AuthRepositoryImpl(this._auth, this.local);

  @override
  Result<Stream<User?>> userAuthStates() {
    try {
      final hasuser = _auth.authStateChanges();
      return Result.onSuccess(hasuser);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  @override
  Future<Result<User?>> login(AuthDomain auth) async {
    try {
      final signin = await _auth.signInWithEmailAndPassword(
        email: auth.email!,
        password: auth.password!,
      );
      if (signin.user != null) {
        return Result.onSuccess(signin.user);
      } else {
        return Result.onfailure('No User');
      }
    } catch (e) {
      return Result.onfailure('Error ${e.toString()}');
    }
  }

  @override
  Future<Result<User?>> signUp(AuthDomain auth) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: auth.email!,
        password: auth.password!,
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
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<Result<void>> cancelverification() async {
    final user = _auth.currentUser;
    try {
      if (user != null && !user.emailVerified) {
        await user.delete();
        return Result.onSuccess(null);
      } else {
        return Result.onfailure('no user exist');
      }
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  @override
  Future<void> saveUser(AuthDomain user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .set(user.toJson(), SetOptions(merge: true));
  }

  @override
  Future<Result<User?>> checkEmailverfication(User? user) async {
    try {
      await user?.reload();
      final freshuser = FirebaseAuth.instance.currentUser;
      if (freshuser != null && freshuser.emailVerified) {
        return Result.onSuccess(freshuser);
      } else {
        return Result.onfailure('not verified');
      }
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  @override
  Future<Result<AuthDomain?>> getUser() async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .get();

    try {
      if (result.data() == null) {
        return Result.onSuccess(null);
      } else {
        final user = AuthDomain.fromJson(result.data()!);
        return Result.onSuccess(user);
      }
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }
}
