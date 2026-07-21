import 'package:chat_shop/src/core/items/domain/item_loacal_repo.dart';
import 'package:chat_shop/src/core/result/result_domain.dart';

class UpdateQuantiy {
  final ItemsRepo repo;
  UpdateQuantiy(this.repo);
  Future<Result<void>> call(String itemId, int quantity) async {
    return await repo.updateQuantity(itemId, quantity);
  }
}
