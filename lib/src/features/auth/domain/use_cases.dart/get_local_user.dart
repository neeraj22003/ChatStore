import 'package:chat_shop/src/features/auth/data/local_auth_prefrence.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';


class GetLocalUserUseCase {
  final LocalAuthPrefrence _repository;

  GetLocalUserUseCase(this._repository);

  Future<AuthDomain?> call() async {
    return await _repository.getUser();
  }
}