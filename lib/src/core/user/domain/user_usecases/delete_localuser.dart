import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_repository.dart';

class DeleteLocaluser {
  final UserRepository repo;
  DeleteLocaluser(this.repo);
  Future<Result<bool>> call() async {
    return await repo.deletelocaluser();
  }
}
