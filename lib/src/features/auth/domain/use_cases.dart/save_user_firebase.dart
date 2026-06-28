import 'package:chat_shop/src/features/auth/data/auth_repository.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';

class SaveUserFirebase {
  final AuthRepository repo;
  SaveUserFirebase(this.repo);
  Future<void> call(AuthDomain user,) async {
    await repo.saveUser(user,);
  }
}
