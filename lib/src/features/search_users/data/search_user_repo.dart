import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/search_users/data/search_user_service.dart';
import 'package:chat_shop/src/features/search_users/domain/search_user_repo.dart';
import 'package:chat_shop/src/features/search_users/domain/searchuser_domain.dart';

class SearchUserRepoImpl implements SearchUserRepo {
  final SearchUserService service;
  SearchUserRepoImpl(this.service);

  @override
  Future<Result<List<SearchuserDomain>>> searchUser(String query) async {
    final result = await service.searchUserFuture(query);
    if (result.isFailure) {
     
      return Result.onfailure(result.error);
    }
    
    return Result.onSuccess(result.data!);
  }
}
