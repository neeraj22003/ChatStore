import 'package:chat_shop/src/core/items/domain/item_loacal_repo.dart';

class GetTotalCost {
  final ItemsRepo repo;
  GetTotalCost(this.repo);
  double call() {
    return repo.totalcost();
  }
}
