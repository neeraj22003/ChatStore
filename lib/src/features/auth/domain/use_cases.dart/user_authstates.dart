import 'package:chat_shop/src/core/domain/result_domain.dart';
import 'package:chat_shop/src/features/auth/data/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthStates {
  final AuthRepository repo;
  UserAuthStates(this.repo);

  Result<Stream<User?>> call()  {
    return repo.userAuthStates();
  }
}
