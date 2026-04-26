import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_shop/src/features/auth/ui/screen/signup_page.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  AuthRepository(this._auth);

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
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

  Future<String?> signUp(String email, String password) async {
    try {
      await Future.delayed(Duration(milliseconds: 100));
      UserCredential signup = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await signup.user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }

  Future<void> cancelverification(BuildContext context) async {
    final user = _auth.currentUser;
    try {
      if (user != null && !user.emailVerified) {
        await user.delete();
      }

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignupPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.code)));
    }
  }
}
