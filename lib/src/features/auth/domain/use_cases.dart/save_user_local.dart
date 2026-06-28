import 'package:chat_shop/src/features/auth/data/local_auth_prefrence.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';


class SaveLocalUserUseCase {
  final LocalAuthPrefrence _repository;

  SaveLocalUserUseCase(this._repository);

  Future<void> call(AuthDomain user) async {
    await _repository.saveUser(user);
  }
}