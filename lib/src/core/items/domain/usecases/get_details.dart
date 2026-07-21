import 'package:chat_shop/src/core/items/domain/item_loacal_repo.dart';
import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';

class GetDetails {
  final ItemsRepo repo;
  GetDetails(this.repo);
  Future<Result<SearchDomain?>> call(String itemId) async {
    return await repo.getdetails(itemId);
  }
}
