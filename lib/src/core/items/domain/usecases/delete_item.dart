import 'package:chat_shop/src/core/items/domain/item_loacal_repo.dart';
import 'package:chat_shop/src/core/result/result_domain.dart';

class DeleteItem {
  final ItemsRepo repo;
  DeleteItem(this.repo);
  Future<Result<void>> call(String itemId) async {
    return await repo.deleteitem(itemId);
  }
}
