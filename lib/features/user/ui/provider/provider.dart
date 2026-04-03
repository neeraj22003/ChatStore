import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/user/data/google_auth_service.dart';
import 'package:flutter_experiments/features/user/data/user_repository.dart';
import 'package:flutter_experiments/features/user/domain/user_domain.dart';

class Userprovider extends ChangeNotifier {
  UserDomain? _userDomain;
  UserDomain? get userDomain => _userDomain;
  bool _loading = false;
  bool get loading => _loading;
  String? get userId => FirebaseAuth.instance.currentUser?.uid;
  Userprovider() {
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
    final user = FirebaseAuth.instance.currentUser;

    return user?.providerData.any(
          (provider) => provider.providerId == ('google.com'),
        ) ??
        false;
  }

  Future<void> linkwithGoogle() async {
    final googleservice = GoogleAuthservice();
    await googleservice.linkwithhgoogle();
    await loaduser(userId!);
    notifyListeners();
  }

  Future<void> unlink() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && islinked) {
      _loading = true;
      notifyListeners();
      await user.unlink('google.com');

      final google = GoogleAuthservice();
      await google.google.signOut();
      await loaduser(user.uid);
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loaduser(String uid) async {
    final load = await UserRepository().loaduser(uid);
    _userDomain = load;
    notifyListeners();
  }
}
