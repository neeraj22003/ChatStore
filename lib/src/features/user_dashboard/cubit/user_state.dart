import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';

class UserState {
  final UserDomain? userdata;
  final bool isloading;
  final String? error;
  final bool islinked;
  UserState({this.userdata, this.isloading=false, this.error, this.islinked=false});

  UserState copywith({
    final UserDomain? userdata,
    final bool? isloading,
    final String? error,
    final bool? islinked,
  }) {
    return UserState(
      userdata: userdata ?? this.userdata,
      isloading: isloading ?? this.isloading,
      error: error ?? this.error,
      islinked: islinked ?? this.islinked,
    );
  }
}
