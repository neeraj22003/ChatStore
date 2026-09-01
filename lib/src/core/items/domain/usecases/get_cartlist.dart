import 'package:chat_shop/src/core/items/domain/item_loacal_repo.dart';
import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';

class GetCartlist {
  final ItemsRepo repo;
  GetCartlist(this.repo);
  List<SearchDomain> call() {
    return repo.getcartlist();
  }
}
