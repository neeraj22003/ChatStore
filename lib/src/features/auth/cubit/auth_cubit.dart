import 'dart:async';

import 'package:chat_shop/src/features/auth/cubit/auth_states.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/usecases_bundle/use_cases_bundle.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthUseCases usecases;
  bool isAnyfunctionrunning = false;
  final ValueNotifier<bool> isSuccess = ValueNotifier(false);
  AuthCubit(this.usecases) : super(Authinitial()) {
    isAnyfunctionrunning
        ? null
        : usecases.userAuthStates.call().data?.listen((user) {
            _verfyUser(user);
          });
  }
  Future<void> logout() async {
    await usecases.logout.call();
  }

  void _verfyUser(User? user, {Timer? timer}) async {
    try {
      await user?.reload();
      final freshuser = FirebaseAuth.instance.currentUser;
      final userObject = await usecases.getLocalUserUseCase.call();

      final emailverified = await usecases.checkEmailVerification.call(user);
      if (freshuser != null) {
        print(freshuser.uid);
        if (userObject == null) {
          emit(
            AuthError(
              error: 'please verify using same device , you used for sign up',
            ),
          );
        } else if (emailverified.data != null) {
           timer?.cancel();
          isSuccess.value = true;
          
          if(timer!=null){
            await usecases.saveUserFirebase.call(userObject);

          }
         
          emit(Authenticated());
        } else {
          emit(NeedVerfication(userObject: userObject));
        }
      } else {
        emit(Authinitial());
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> onTapCancel() async {
    isAnyfunctionrunning = isAnyfunctionrunning;
    emit(Authloading());
    try {
      final delete = await usecases.cancelVerfication.call();
      if (delete.isSuccess) {
        emit(Authinitial());
      } else {
        emit(AuthError(error: delete.error));
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> onStartverification() async {
    isAnyfunctionrunning = true;
    final freshuser = FirebaseAuth.instance.currentUser;
    await freshuser?.sendEmailVerification();
    Timer.periodic(const Duration(seconds: 4), (timer) async {
      _verfyUser(freshuser, timer: timer);
    });
  }

  Future<void> signIn(AuthDomain user) async {
    isAnyfunctionrunning = true;
    emit(Authloading());
    try {
      final signin = await usecases.singIN.call(user);
      if (signin.isSuccess) {
        if (signin.data != null && signin.data!.emailVerified) {
          emit(Authenticated());
        } else {
          _verfyUser(signin.data);
        }
      } else {
        emit(AuthError(error: signin.error));
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> signup(AuthDomain user) async {
    isAnyfunctionrunning = true;
    emit(Authloading());
    try {
      final signup = await usecases.signUp.call(auth: user);
      await usecases.saveLocaluser(user);

      if (signup.isSuccess && signup.data != null) {
        emit(NeedVerfication(userObject: user));
      } else {
        emit(AuthError(error: signup.error));
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }
}
