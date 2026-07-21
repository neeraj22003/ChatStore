import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_repository.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';

class SaveUser {
  final UserRepository repo;
  SaveUser(this.repo);
  Future<Result<void>> call(AuthDomain user) async {
    return repo.saveUser(user);
  }
}
