import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/core/user/domain/user_repository.dart';

class SaveUser {
  final UserRepository repo;
  SaveUser(this.repo);
  Future<Result<void>> call(UserDomain user) async {
    return repo.saveUser(user);
  }
}
