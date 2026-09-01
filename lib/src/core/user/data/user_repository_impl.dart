import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/core/user/domain/user_firestore.dart';
import 'package:chat_shop/src/core/user/domain/user_localdb.dart';
import 'package:chat_shop/src/core/user/domain/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserStore userFirestore;
  final UserLocaldb localdb;
  UserDomain? _userDomain;
  UserRepositoryImpl(this.userFirestore, this.localdb);
  @override
  UserDomain get user => _userDomain!;
  @override
  Future<Result<UserDomain>> getUser() async {
    if (_userDomain != null) {
      return Result.onSuccess(_userDomain!);
    }

    final localuser = await localdb.getUser();
    if (localuser.isFailure) {
      return Result.onfailure(localuser.error);
    }
    if (localuser.data != null) {
      _userDomain = localuser.data;

      return Result.onSuccess(_userDomain!);
    }

    final user = await userFirestore.getUser();

    if (user.isFailure) {
      return Result.onfailure(user.error);
    }

    if (user.data != null) {
      print('nad');

      final result = await localdb.saveUser(user.data!);
      if (result.isFailure) {
        return Result.onfailure(result.error);
      }
      _userDomain = user.data;

      return Result.onSuccess(_userDomain!);
    }

    return Result.onfailure('no user');
  }

  @override
  Future<Result<bool>> injectprofileimage() async {
    final store = await userFirestore.injectprofileimage();
    if (store.isFailure) {
      return Result.onfailure(store.error);
    }
    final local = await localdb.updateprofile(store.data);
    if (local.isFailure) {
      return Result.onfailure(local.error);
    }
    _userDomain?.profileimage == store.data;
    return Result.onSuccess(local.data!);
  }

  @override
  Future<Result<bool>> saveUser(UserDomain user) async {
    final localsave = await localdb.saveUser(user);
    if (localsave.isFailure) {
      return Result.onfailure(localsave.error);
    }
    final store = await userFirestore.saveUser(user);
    if (store.isFailure) {
      return Result.onfailure(store.error);
    }
    return Result.onSuccess(true);
  }

  @override
  Future<Result<bool>> deletelocaluser() async {
    final result = await localdb.deletelocaluser();
    if (result.isFailure) {
      return Result.onfailure(result.error);
    }
    _userDomain = null;
    return Result.onSuccess(result.data!);
  }
}
