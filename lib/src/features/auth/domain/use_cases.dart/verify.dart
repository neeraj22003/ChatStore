import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/auth/domain/auth_repo.dart';


class Verify {
  final AuthRepository repo;
  Verify(this.repo);

 Future<Result<bool>> call()async  {
    return await repo.verify();
  }
}
