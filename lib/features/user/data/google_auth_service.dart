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

class GoogleAuthservice {
  GoogleSignIn get google => _googlesignin;
  Future<String?> linkwithhgoogle() async {
    try {
      await _googlesignin.signOut();
      final credentials = await _googlesignin.signIn();
      print(credentials!.accessToken);
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: credentials.idToken,
        accessToken: credentials.accessToken,
      );

      final currentUser = FirebaseAuth.instance.currentUser!;

      await currentUser.linkWithCredential(credential);

      // Refresh the user to see the new providerData
      await currentUser.reload();
      final updatedUser = FirebaseAuth.instance.currentUser;

      // Safely find the photo URL
      final googleData = updatedUser?.providerData
          .where((data) => data.providerId == 'google.com')
          .firstOrNull;

      if (googleData?.photoURL != null) {
        await UserRepository().injectprofileimage(
          updatedUser!.uid,
          googleData!.photoURL,
        );
      }

      return null; // Success
    } on FirebaseAuthException catch (e) {
      print("Firebase Error: ${e.code}");
      print("object${e.message}");
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }
}
