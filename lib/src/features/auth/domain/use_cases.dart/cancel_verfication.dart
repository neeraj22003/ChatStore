import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/auth/domain/auth_repo.dart';


class CancelVerfication {
  final AuthRepository repo;
  CancelVerfication(this.repo);
  Future<Result<void>> call() async {
    return repo.cancelverification();
  }
}
