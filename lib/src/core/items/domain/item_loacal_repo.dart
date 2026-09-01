import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:chat_shop/src/core/result/result_domain.dart';

abstract class ItemsRepo {
  Future<Result<void>> saveitemtolocaldb(SearchDomain item);
  Future<Result<List<SearchDomain>?>> loaditemfromlocaldb();
  Future<Result<SearchDomain?>> getdetails(String itemid);
  Future<Result<void>> updateQuantity(String itemid, int quantity);
  List<SearchDomain> getcartlist();
  double totalcost();
  Future<Result<void>> deleteitem(String itemId);
  Future<Result<bool>> clearCart();
}
