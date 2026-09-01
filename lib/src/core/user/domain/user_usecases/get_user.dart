import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/core/user/domain/user_repository.dart';

class GetUser {
  final UserRepository repo;
  GetUser(this.repo);
  Future<Result<UserDomain>> call() async {
    return repo.getUser();
  }
}
