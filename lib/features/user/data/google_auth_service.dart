import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_experiments/features/user/data/user_repository.dart';
import 'package:google_sign_in_all_platforms/google_sign_in_all_platforms.dart';

final GoogleSignIn _googlesignin = GoogleSignIn(
  params: GoogleSignInParams(
    clientId:
        '441564765916-oppmjrfch1e9f4emtmsd13e91il5bm6m.apps.googleusercontent.com',
    clientSecret: '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',
    redirectPort: 8000,
  ),
);
User? get currentUser => FirebaseAuth.instance.currentUser;

class GoogleAuthservice {
  Future<void> updateprofile() async {
    await currentUser?.reload();
    final updatedUser = FirebaseAuth.instance.currentUser;

    final googleData = updatedUser?.providerData
        .where((data) => data.providerId == 'google.com')
        .firstOrNull;

    if (googleData?.photoURL != null) {
      await UserRepository().injectprofileimage(
        updatedUser!.uid,
        googleData!.photoURL,
      );
    }
  }

  GoogleSignIn get google => _googlesignin;
  Future<String?> linkwithhgoogle() async {
    try {
      await _googlesignin.signOut();
      final credentials = await _googlesignin.signIn();

      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: credentials?.idToken,
        accessToken: credentials?.accessToken,
      );

      await currentUser?.linkWithCredential(credential);
      await updateprofile();

      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }
}
