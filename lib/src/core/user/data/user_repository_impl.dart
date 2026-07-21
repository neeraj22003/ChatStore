import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/data/user_domain_dto.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/core/user/domain/user_firestore.dart';
import 'package:chat_shop/src/core/user/domain/user_localdb.dart';
import 'package:chat_shop/src/core/user/domain/user_repository.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

      final userr = AuthDomain(
        id: 'MHxOKSBan2dzj60RFo1kwpzl0tq2',

        email: user.data!.email,

        address: user.data!.address,

        name: user.data!.name,

        phone: user.data!.phone,

        profile: user.data!.profileimage,
      );

      final result = await localdb.saveUser(userr);
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
    return await userFirestore.injectprofileimage();
  }

  @override
  Future<Result<bool>> saveUser(AuthDomain user) async {
    final localsave = await localdb.saveUser(user);
    if (localsave.isFailure) {
      return Result.onfailure(localsave.error);
    }
    final store = await userFirestore.saveUser(user);
    if (store.isFailure) {
      return Result.onfailure(store.error);
    }
    return Result.onSuccess(store.data!);
  }
}
