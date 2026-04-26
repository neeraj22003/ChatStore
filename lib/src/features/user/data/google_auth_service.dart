import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:chat_shop/src/features/user/data/user_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googlesignin = GoogleSignIn.instance;
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
      await _googlesignin.initialize(serverClientId: dotenv.env['CLIENT_ID']);
      final GoogleSignInAccount googleuser = await _googlesignin.authenticate();
      final authclient = await googleuser.authorizationClient.authorizeScopes([
        'email',
        'profile',
        'openid',
      ]);
      final GoogleSignInAuthentication googleauth = googleuser.authentication;

      final AuthCredential cred = GoogleAuthProvider.credential(
        idToken: googleauth.idToken,
        accessToken: authclient.accessToken,
      );

      await currentUser?.linkWithCredential(cred);
      await updateprofile();

      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }
}
