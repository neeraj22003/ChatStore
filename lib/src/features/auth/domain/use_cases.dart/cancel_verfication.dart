import 'package:chat_shop/src/core/domain/result_domain.dart';
import 'package:chat_shop/src/features/auth/data/auth_repository.dart';

class CancelVerfication {
  final AuthRepository repo;
  CancelVerfication(this.repo);
  Future<Result<void>> call() async {
    return repo.cancelverification();
  }
}
