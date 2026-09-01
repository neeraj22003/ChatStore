
import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/auth/domain/auth_repo.dart';

class Logout {
  final AuthRepository repo;
  Logout(this.repo);
  Future<Result<bool>> call() async {
    return  await repo.logout();
  }
}
