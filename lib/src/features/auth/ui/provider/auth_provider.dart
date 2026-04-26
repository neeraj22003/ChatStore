import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_shop/src/features/auth/data/auth_repository.dart';
import 'package:chat_shop/src/features/auth/ui/screen/verify_page.dart';
import 'package:chat_shop/src/features/user/data/user_repository.dart';
import 'package:chat_shop/src/features/user/domain/user_domain.dart';
import 'package:chat_shop/src/features/user/ui/provider/provider.dart';

class Authprovider extends ChangeNotifier {
  final GlobalKey<ScaffoldMessengerState> _snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  GlobalKey<ScaffoldMessengerState> get snacbarkey => _snackbarKey;

  bool _isverified = false;
  bool get verified => _isverified;
  FirebaseAuth get auth => FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;
  Timer? _timer;
  // ignore: unused_field
  UserDomain? _user;
  UserDomain? get user => _user;

  void getuserdata(UserDomain user) {
    _user = user;
    notifyListeners();
  }

  void startVerificationPolling(Userprovider userprovider) {
    if (_timer != null) return;

    _timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      await checkverification(userprovider);
      if (_isverified) stopVerificationPolling();
    });
  }

  void stopVerificationPolling() {
    _timer?.cancel();
    _timer = null;
  }

  void loding() {
    _loading = true;
    notifyListeners();
  }

  void stoploading() {
    _loading = false;
    notifyListeners();
  }

  Future<void> checkverification(Userprovider userprovider) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    _isverified = user?.emailVerified ?? false;
    if (_isverified) {
      await UserRepository.saveUser(_user!, user!.uid);
      await userprovider.loaduser(user.uid);
    }
    notifyListeners();
  }

  Future<void> signUp(
    String email,
    String password,

    BuildContext context,
  ) async {
    final error = await AuthRepository(auth).signUp(email, password);

    if (error == null) {
      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VerifyPage()),
      );
    } else {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  Future<void> login(String email, String passwrod) async {
    loding();
    final error = await AuthRepository(auth).login(email, passwrod);

    if (error != null) {
      await Future.delayed(const Duration(milliseconds: 200));

      _snackbarKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: const Color.fromARGB(255, 144, 25, 66),
        ),
      );
    } else {}
    stoploading();
  }

  @override
  void dispose() {
    stopVerificationPolling();
    super.dispose();
  }
}
