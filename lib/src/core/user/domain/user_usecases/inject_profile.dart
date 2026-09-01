import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_repository.dart';

class InjectProfile {
  final UserRepository repo;
  InjectProfile(this.repo);
  Future<Result<void>> call() async {
    return repo.injectprofileimage();
  }
}
