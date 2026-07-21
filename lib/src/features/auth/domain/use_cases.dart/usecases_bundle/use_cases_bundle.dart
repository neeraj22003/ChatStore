
import 'package:chat_shop/src/features/auth/domain/auth_repo.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/cancel_verfication.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/verify.dart';

import 'package:chat_shop/src/features/auth/domain/use_cases.dart/logout.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/sign_in_user.dart';
import 'package:chat_shop/src/features/auth/domain/use_cases.dart/sign_up_user.dart';

class AuthUseCases {
  final SignUpUser signUp;
  final Verify verify;
  final SignInUser singIN;

  
  final CancelVerfication cancelVerfication;

  final Logout logout;
  AuthUseCases(AuthRepository repo)
    : signUp = SignUpUser(repo),
      verify=Verify(repo),
      singIN = SignInUser(repo),

      cancelVerfication = CancelVerfication(repo),
      logout = Logout(repo);
}
