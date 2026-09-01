

abstract class AuthStates {}

class Authinitial extends AuthStates {}

class Authloading extends AuthStates {}

class NeedVerfication extends AuthStates {
  final String email;
  NeedVerfication({required this.email});
}

class Authenticated extends AuthStates {}

class AuthError extends AuthStates {
  final String? error;
  AuthError({required this.error});
}

