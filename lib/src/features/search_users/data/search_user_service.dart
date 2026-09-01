import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/search_users/data/search_user_dto.dart';
import 'package:chat_shop/src/features/search_users/domain/searchuser_domain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchUserService {
  Future<Result<List<SearchuserDomain>>> searchUserFuture(String query) async {
    
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('query')
          .startAt([query])
          .endAt(['$query\uf8ff'])
          .get();
      if (result.docs.isNotEmpty) {
        final userlist = result.docs.map((data) {
          return SearchuserDto.fromJson(data.data()).touserDomain();
        }).toList();
        return Result.onSuccess(userlist);
      }
      return Result.onfailure('no user ');
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }
}
