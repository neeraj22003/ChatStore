import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chat_shop/src/features/user/domain/user_domain.dart';

class UserRepository {
  Future<void> injectprofileimage(String userId, String? profileimage) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'profileimage': profileimage,
    });
  }

  Future<UserDomain?> loaduser(String userid) async {
    final user = await FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .get();

    return UserDomain.fromJson(user.data() ?? {});
  }

  static Future<void> saveUser(UserDomain user, String userId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(user.toJson(), SetOptions(merge: true));
  }
}
