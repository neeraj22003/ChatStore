import 'package:chat_shop/src/core/items/domain/item_loacal_repo.dart';
import 'package:chat_shop/src/core/items/domain/usecases/clear_cart.dart';

import 'package:chat_shop/src/core/items/domain/usecases/delete_item.dart';
import 'package:chat_shop/src/core/items/domain/usecases/get_cartlist.dart';
import 'package:chat_shop/src/core/items/domain/usecases/get_total_cost.dart';

import 'package:chat_shop/src/core/items/domain/usecases/load_item.dart';
import 'package:chat_shop/src/core/items/domain/usecases/save_item.dart';
import 'package:chat_shop/src/core/items/domain/usecases/get_details.dart';
import 'package:chat_shop/src/core/items/domain/usecases/update_quantiy.dart';

class ItemUseCases {
  final SaveItem saveItem;
  final LoadItem loadItem;
  final GetDetails getDetails;
  final UpdateQuantiy updateQuantiy;
  final DeleteItem deleteItem;
  final GetCartlist getCartlist;
  final GetTotalCost getTotalCost;
  final ClearCart clearCart;
  ItemUseCases(ItemsRepo repo)
    : saveItem = SaveItem(repo),
      loadItem = LoadItem(repo),
      getDetails = GetDetails(repo),
      updateQuantiy = UpdateQuantiy(repo),
      getCartlist = GetCartlist(repo),
      getTotalCost = GetTotalCost(repo),
      clearCart = ClearCart(repo),
      deleteItem = DeleteItem(repo);
}
