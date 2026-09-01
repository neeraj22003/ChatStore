import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/search_users/domain/searchuser_domain.dart';

abstract class SearchUserRepo {
  
  Future<Result<List<SearchuserDomain>>> searchUser(String query);
}
