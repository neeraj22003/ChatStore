import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';

abstract class SearchRepo {
 
  Future<Result<List<SearchDomain>>> searchItems(String? query);
  Future<Result<List<SearchDomain>>> feeditems();
  Future<Result<List<SearchDomain>>> getcategoryitem(String? id);

}
