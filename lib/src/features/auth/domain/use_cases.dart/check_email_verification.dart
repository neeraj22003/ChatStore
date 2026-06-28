import 'package:chat_shop/src/core/domain/result_domain.dart';
import 'package:chat_shop/src/features/auth/data/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckEmailVerification {
  final AuthRepository repo;
  CheckEmailVerification(this.repo);
  Future<Result<User?>> call(User? user) async {
    return await repo.checkEmailverfication(user);
  }
}
