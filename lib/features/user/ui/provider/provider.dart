import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/user/data/google_auth_service.dart';
import 'package:flutter_experiments/features/user/data/user_repository.dart';
import 'package:flutter_experiments/features/user/domain/user_domain.dart';

class Userprovider extends ChangeNotifier {
  UserDomain? _userDomain;
  UserDomain? get userDomain => _userDomain;

  Userprovider() {
    final initialuser = FirebaseAuth.instance.currentUser;
    if (initialuser != null) {
      loaduser(initialuser.uid);
    }
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null && user.emailVerified) {
        loaduser(user.uid);
      }
      notifyListeners();
    });
  }
  void logout() async {
    _userDomain = null;
    notifyListeners();
    final google = GoogleAuthservice();
    await google.google.signOut();
    FirebaseAuth.instance.signOut();
  }

  bool get islinked {
    return userDomain?.profileimage != null;
  }

  Future<void> linkwithGoogle() async {
    final googleservice = GoogleAuthservice();
    await googleservice.linkwithhgoogle();
    notifyListeners();
  }

  Future<void> loaduser(String uid) async {
    final load = await UserRepository().loaduser(uid);
    _userDomain = load;
    notifyListeners();
  }
}
