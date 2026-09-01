import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';

abstract class UserStore {
  Future<Result<bool>> saveUser(UserDomain user);
  Future<Result<UserDomain>> getUser();
  Future<Result<String?>> injectprofileimage();
}