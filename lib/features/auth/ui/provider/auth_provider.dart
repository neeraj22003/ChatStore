import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_experiments/features/user/data/user_repository.dart';
import 'package:flutter_experiments/features/user/domain/user_domain.dart';

class Authprovider extends ChangeNotifier {
  final TextEditingController _namecontroller = TextEditingController();
  TextEditingController get namecontroller => _namecontroller;
  final TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController get passwordcontroller => _passwordcontroller;
  final GlobalKey<FormState> _Formkey = GlobalKey<FormState>();
  GlobalKey<FormState> get formkey => _Formkey;
  final GlobalKey<ScaffoldMessengerState> _snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  GlobalKey<ScaffoldMessengerState> get snacbarkey => _snackbarKey;
  User? get islogedin => _auth.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseFirestore get db => _db;
  bool _verified = false;
  bool get verified => _verified;
  bool _loading = false;
  bool get loading => _loading;
  String? _creatdemail;
  String? get createdemail => _creatdemail;
  String? _tempname;
  String? _tempaddres;
  String? _phone;
  User? user = FirebaseAuth.instance.currentUser;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _namecontroller.clear();
    _passwordcontroller.clear();
    super.dispose();
  }

  void loding() {
    _loading = true;
    notifyListeners();
  }

  void stoploading() {
    _loading = false;
    notifyListeners();
  }

  Future<String?> savecredentials(
    String name,
    String email,
    String password,
    String address,
    String phone,
  ) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _tempname = name;
      _tempaddres = address;
      _phone = phone;
      _creatdemail = email;
      await credential.user!.sendEmailVerification();
      verifyproccess();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return e.code;
      }
    }
    return null;
  }

  Future<void> verify() async {
    User? user = _auth.currentUser;

    await user?.reload();
    _creatdemail = user?.email;
    _verified = user?.emailVerified ?? false;
    if (_verified && _tempname != null) {
      final userdomain = UserDomain(
        name: _tempname!,
        address: _tempaddres!,
        email: _creatdemail!,
        phone: _phone!,
        profileimage: null,
      );
      await UserRepository().saveUser(userdomain, user!.uid);

      _timer?.cancel();
    }

    notifyListeners();
  }

  void verifyproccess() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      verify();
    });
    notifyListeners();
  }

  Future<String?> login(String email, String passwrod) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: passwrod);
      stoploading();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          return 'Incorrect password';
        case 'user-not-found':
          return 'No user found with this email';
        case 'invalid-email':
          return 'Invalid email format';
        case 'user-disabled':
          return 'This account has been disabled';
        default:
          return 'Login failed: ${e.code}';
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  void logut() {
    _auth.signOut();
    _loading = false;
    notifyListeners();
  }

  /*Future<void> setloginstate()async{
  final pref=await SharedPreferences.getInstance();
  await pref.setBool('login', _islogedin);
 }
 Future<void>getloginstate()async{
  final pref=await SharedPreferences.getInstance();
  _islogedin=pref.getBool('login')??false;
   notifyListeners();
 }*/
}
