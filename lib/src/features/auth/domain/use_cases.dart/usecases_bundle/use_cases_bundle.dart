import 'package:chat_shop/src/features/auth/data/auth_repository.dart';
import 'package:chat_shop/src/features/auth/data/local_auth_prefrence.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/cancel_verfication.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/check_email_verification.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/user_authstates.dart';

import 'package:chat_shop/src/features/auth/domain/use_cases.dart/get_local_user.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/logout.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/save_user_firebase.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/save_user_local.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/sign_in_user.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/sign_up_user.dart';

class AuthUseCases {
  final SignUpUser signUp;
  final UserAuthStates userAuthStates;
  final SignInUser singIN;
  final SaveLocalUserUseCase saveLocaluser;
  final GetLocalUserUseCase getLocalUserUseCase;
  final CheckEmailVerification checkEmailVerification;
  final SaveUserFirebase saveUserFirebase;
  final CancelVerfication cancelVerfication;

  final Logout logout;
  AuthUseCases(AuthRepository repo)
    : signUp = SignUpUser(repo),
      userAuthStates = UserAuthStates(repo),
      singIN = SignInUser(repo),
      saveLocaluser = SaveLocalUserUseCase(LocalAuthPrefrence()),
      getLocalUserUseCase = GetLocalUserUseCase(LocalAuthPrefrence()),
      checkEmailVerification=CheckEmailVerification(repo),
      saveUserFirebase = SaveUserFirebase(repo),
      cancelVerfication = CancelVerfication(repo),
      logout = Logout(repo);
}
