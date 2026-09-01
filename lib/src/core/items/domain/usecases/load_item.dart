import 'package:chat_shop/src/core/items/domain/item_loacal_repo.dart';
import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:chat_shop/src/core/result/result_domain.dart';

class LoadItem {
  final ItemsRepo repo;
  LoadItem(this.repo);
  Future<Result<List<SearchDomain>?>> call() async {
    return await repo.loaditemfromlocaldb();
  }
}
