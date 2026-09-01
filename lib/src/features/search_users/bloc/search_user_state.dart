import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/features/search_users/domain/searchuser_domain.dart';

abstract class SearchUserState {}

class SearchUserInitial extends SearchUserState {}

class SearchUserLoaded extends SearchUserState {
  final List<SearchuserDomain> users;
  final UserDomain currentuser;
  SearchUserLoaded(this.users,this.currentuser);
}

class SearchUserLoading extends SearchUserState {}

class SearchUserError extends SearchUserState {
  final String? error;
  SearchUserError(this.error);
}
