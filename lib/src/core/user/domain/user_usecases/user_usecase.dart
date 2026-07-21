import 'package:chat_shop/src/core/user/domain/user_repository.dart';
import 'package:chat_shop/src/core/user/domain/user_usecases/get_user.dart';
import 'package:chat_shop/src/core/user/domain/user_usecases/inject_profile.dart';
import 'package:chat_shop/src/core/user/domain/user_usecases/save_user.dart';


class UserUsecase {
  final SaveUser saveUser;
  final GetUser getUser;
  final InjectProfile injectProfile;
 
  UserUsecase(UserRepository repo)
    : saveUser = SaveUser(repo),
      getUser = GetUser(repo),
     
      injectProfile = InjectProfile(repo);
}
