import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:chat_shop/src/features/search/domain/search_repo.dart';

class SearchItem {
  final SearchRepo repo;
  SearchItem(this.repo);
  Future<Result<List<SearchDomain>>> call(String? query) async {
    return await repo.searchItems(query);
  }
}
