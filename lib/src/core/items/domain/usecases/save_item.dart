import 'package:chat_shop/src/core/items/domain/item_loacal_repo.dart';
import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:chat_shop/src/core/result/result_domain.dart';

class SaveItem {
  final ItemsRepo repo;
  SaveItem(this.repo);
  Future<Result<void>> call(SearchDomain item) async {
    return await repo.saveitemtolocaldb(item);
  }
}
