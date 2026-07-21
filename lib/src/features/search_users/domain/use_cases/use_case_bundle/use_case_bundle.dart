import 'package:chat_shop/src/features/search_users/domain/use_cases/search_user.dart';
import 'package:chat_shop/src/features/search_users/domain/search_user_repo.dart';

class SearchuserUseCase {
  final SearchUser searchUser;
  SearchuserUseCase(SearchUserRepo repo) : searchUser = SearchUser(repo);
}
