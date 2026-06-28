import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';

abstract class AuthStates {}

class Authinitial extends AuthStates {}

class Authloading extends AuthStates {}

class NeedVerfication extends AuthStates {
  final AuthDomain userObject;
  NeedVerfication({required this.userObject});
}

class Authenticated extends AuthStates {}

class AuthError extends AuthStates {
  final String? error;
  AuthError({required this.error});
}

