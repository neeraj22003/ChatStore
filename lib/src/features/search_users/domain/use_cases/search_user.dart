
import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/search_users/domain/search_user_repo.dart';
import 'package:chat_shop/src/features/search_users/domain/searchuser_domain.dart';

class SearchUser {
  final SearchUserRepo repo;
  SearchUser(this.repo);
  Future<Result<List<SearchuserDomain>>> call(String query) async {
    return await repo.searchUser(query);
  }
}
