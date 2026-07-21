import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class MyGoogleService {
  GoogleSignIn get google;
  Future<Result<void>> linkwithhgoogle();
}

final GoogleSignIn _googlesignin = GoogleSignIn.instance;
User? get currentUser => FirebaseAuth.instance.currentUser;

class GoogleAuthservice extends MyGoogleService {
  @override
  GoogleSignIn get google => _googlesignin;
  @override
  Future<Result<void>> linkwithhgoogle() async {
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

      return Result.onSuccess(null);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }
}
