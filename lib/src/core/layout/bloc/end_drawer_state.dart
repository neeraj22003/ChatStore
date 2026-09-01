import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';

abstract class EndDrawerState {}

class Endrawerclosed extends EndDrawerState {}

class IsAcountDasboard extends EndDrawerState {}

class IsCart extends EndDrawerState {
  final int length;
  final UserDomain user;
  IsCart(this.length,this.user);
}
