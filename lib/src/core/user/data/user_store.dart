import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/data/user_domain_dto.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/core/user/domain/user_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserStoreImpl implements UserStore {
  final FirebaseFirestore store;
  final FirebaseAuth auth;
  UserStoreImpl(this.store, this.auth);

  @override
  Future<Result<UserDomain>> getUser() async {
    print(auth.currentUser!.uid);
    try {
      final user = await store
          .collection('users')
          .doc(auth.currentUser?.uid)
          .get();
      if (user.exists) {
        final data = UserDto.fromJson(user.data() ?? {});
        final domain = data.toDomain();

        return Result.onSuccess(domain);
      } else {
        return Result.onfailure('no user exist yet');
      }
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  @override
  Future<Result<String?>> injectprofileimage() async {
    try {
      await auth.currentUser?.reload();
      final reloadeduser = FirebaseAuth.instance.currentUser;
      final profileimge = reloadeduser?.providerData
          .map((data) => data.photoURL)
          .first;

      await store.collection('users').doc(auth.currentUser?.uid).update({
        'profileimage': profileimge,
      });
      return Result.onSuccess(profileimge);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  @override
  Future<Result<bool>> saveUser(UserDomain user) async {
    final userdata = UserDto(
      id: user.id,
      name: user.name,
      address: user.address,
      email: user.email,
      phone: user.phone,
    );
    try {
      await store
          .collection('users')
          .doc(auth.currentUser?.uid)
          .set(userdata.toJson(), SetOptions(merge: true));
      return Result.onSuccess(true);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }
}
