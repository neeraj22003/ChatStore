import 'package:chat_shop/src/features/auth/data/auth_repository.dart';
import 'package:http/http.dart';

class Logout {
  final AuthRepository repo;
  Logout(this.repo);
  Future<void> call() async {
    await repo.logout();
  }
}
