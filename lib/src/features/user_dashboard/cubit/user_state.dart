import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';

abstract class UserDashBoardState {}

class UserDashBoardInitial extends UserDashBoardState {}

class UserDashBoardLoading extends UserDashBoardState {}

class UserDashBoardLoaded extends UserDashBoardState {
  final UserDomain user;
  final bool islinked;
  UserDashBoardLoaded({required this.user,required this.islinked});
}

class UserDashBoardError extends UserDashBoardState {
  final String? error;
  UserDashBoardError(this.error);
}
