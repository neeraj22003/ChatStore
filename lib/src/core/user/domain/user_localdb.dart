import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';

abstract class UserLocaldb {
  Future<Result<bool>> saveUser(AuthDomain user);
  Future<Result<UserDomain?>> getUser();
 
}
