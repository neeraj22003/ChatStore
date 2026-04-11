import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_experiments/features/auth/data/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Login Success', () async {
    final repo = AuthRepository(FakeFirebaseAuth());
    final result = await repo.login('neeraj@gmail.com', 'yog');
    expect(result, null);
  });
  test('Login failed', () async {
    final repo = AuthRepository(FakeFirebaseAuth());
    final result = await repo.login('neeraj@gmail.com', 'yoga');
    expect(result, 'Incorrect password');
  });

  test('signup test:email already exist ', () async {
    final repo = AuthRepository(FakeFirebaseAuth());
    final result = await repo.signUp('neeraj@gmail.com', 'lol');
    expect(result, 'email-already-in-use');
  });
}

class FakeFirebaseAuth extends Fake implements FirebaseAuth {
  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (email == 'neeraj@gmail.com' && password == 'yog') {
      return Future.value(UserCredentialFake());
    } else {
      throw FirebaseAuthException(
        code: 'wrong-password',
        message: 'bad-password',
      );
    }
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final database = {'email': 'neeraj@gmail.com'};
    if (email != database['email']) {
      return Future.value(UserCredentialFake());
    } else {
      throw FirebaseAuthException(code: 'email-already-in-use');
    }
  }
}

class UserCredentialFake implements UserCredential {
  @override
  // TODO: implement additionalUserInfo
  AdditionalUserInfo? get additionalUserInfo => throw UnimplementedError();

  @override
  // TODO: implement credential
  AuthCredential? get credential => throw UnimplementedError();

  @override
  // TODO: implement user
  User? get user => throw UnimplementedError();
}
