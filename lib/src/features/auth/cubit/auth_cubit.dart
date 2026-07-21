import 'dart:async';

import 'package:chat_shop/src/core/user/domain/user_usecases/user_usecase.dart';
import 'package:chat_shop/src/features/auth/cubit/auth_states.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/usecases_bundle/use_cases_bundle.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthUseCases authusecases;
  final UserUsecase userUsecase;

  bool isAnyfunctionrunning = false;
  final ValueNotifier<bool> isSuccess = ValueNotifier(false);
  AuthCubit(this.authusecases, this.userUsecase) : super(Authinitial());

  Future<void> logout() async {
    final reslult = await authusecases.logout.call();
    if (reslult.isFailure) {
      emit(AuthError(error: reslult.error));
    }
    emit(Authinitial());
  }

  Future<void> onTapCancel() async {
    isAnyfunctionrunning = isAnyfunctionrunning;
    emit(Authloading());
    try {
      final delete = await authusecases.cancelVerfication.call();
      if (delete.isSuccess) {
        emit(Authinitial());
      } else {
        emit(AuthError(error: delete.error));
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> verify() async {
    final result = await authusecases.verify.call();
    if (result.isFailure) {
      emit(AuthError(error: result.error));
    }
    if (result.data != null && result.data!) {
      emit(Authenticated());
    } else {
      emit(Authinitial());
    }
  }

  Future<void> signIn(AuthDomain user) async {
    emit(Authloading());

    final signin = await authusecases.singIN.call(user);
    if (signin.isFailure) {
      emit(AuthError(error: signin.error));
    }

    if (signin.data != null) {
      await userUsecase.getUser.call();
      emit(Authenticated());
    } else {
      final userdata = await userUsecase.getUser.call();
      if (userdata.isFailure) {
        emit(AuthError(error: userdata.error));
      }
      emit(NeedVerfication(email: userdata.data!.email));
    }
  }

  Future<void> signup(AuthDomain user) async {
    isAnyfunctionrunning = true;
    emit(Authloading());

    final signup = await authusecases.signUp.call(auth: user);
    if (signup.isFailure) {
      emit(AuthError(error: signup.error));
    }
    final saveuser = await userUsecase.saveUser.call(user);

    if (saveuser.isFailure) {
      emit(AuthError(error: saveuser.error));
    }
    emit(NeedVerfication(email: user.email!));
  }
}
