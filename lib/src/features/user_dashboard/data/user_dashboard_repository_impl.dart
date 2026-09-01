import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/user_dashboard/data/google_auth_service.dart';
import 'package:chat_shop/src/features/user_dashboard/domain/user_dashboard_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDashboardRepositoryImpl implements UserDashboardRepository {
  final MyGoogleService googleAuthservice;
  

  UserDashboardRepositoryImpl(this.googleAuthservice,);

  @override
  Future<Result<void>> linkwithhgoogle() async {
    return await googleAuthservice.linkwithhgoogle();
  }

  @override
  Future<Result<void>> unlink() async {
    try {
      await FirebaseAuth.instance.currentUser?.unlink('google.com');
      await googleAuthservice.google.signOut();
    } catch (e) {
      return Result.onfailure(e.toString());
    }
    return Result.onSuccess(null);
  }

  @override
  Future<Result<bool>> isUserlinked() async {
    try {
      final refresheduser = FirebaseAuth.instance.currentUser;
      if (refresheduser != null) {
        final islink = refresheduser.providerData.any(
          (data) => data.providerId == 'google.com',
        );
        return Result.onSuccess(islink);
      } else {
        return Result.onSuccess(false);
      }
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }
}
