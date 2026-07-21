import 'package:chat_shop/src/core/items/data/items_localdb.dart';
import 'package:chat_shop/src/core/items/domain/item_loacal_repo.dart';
import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/currency_service/currency_service.dart';
import 'package:chat_shop/src/core/items/data/ebay_service.dart';
import 'package:chat_shop/src/core/items/data/ebayitem_dto.dart';
import 'package:chat_shop/src/core/items/data/search_dto.dart';

class ItemsRepoimpl implements ItemsRepo {
  final ItemsLocaldb db;
  final EbuyService _dataSource;
  final CurrencyService _currencyService;
  Map<String, SearchDomain> bottomcache = {};
  Map<String, SearchDomain> cartcache = {};
  ItemsRepoimpl(this.db, this._dataSource, this._currencyService);

  @override
  Future<Result<void>> saveitemtolocaldb(SearchDomain items) async {
    cartcache[items.itemId] = items;
    return await db.savedb(items);
  }

  @override
  Future<Result<List<SearchDomain>?>> loaditemfromlocaldb() async {
    final item = await db.loaditems();
    if (item.data == null) {
      return Result.onSuccess(null);
    } else if (item.data != null) {
      for (var i in item.data!) {
        bottomcache[i.itemId] = i;
        cartcache[i.itemId] = i;
      }

      return Result.onSuccess(item.data);
    } else {
      return Result.onfailure(item.error);
    }
  }

  @override
  double totalcost() {
    double cost = 0.0;
    for (var i in cartcache.values) {
      cost += (i.inrprice ?? 0) * i.quantity;
    }
    return cost;
  }

  void addcacheitem(String key, SearchDomain item) {
    if (bottomcache.length >= 6) {
      final firstitem = bottomcache.keys.first;
      bottomcache.remove(firstitem);
    }
    bottomcache[key] = item;
  }

  @override
  Future<Result<SearchDomain?>> getdetails(String itemId) async {
    try {
      if (bottomcache.containsKey(itemId)) {
        return Result.onSuccess(bottomcache[itemId]);
      } else {
        final raw = await _dataSource.itemDiscription(itemId);
        if (raw == null) return Result.onSuccess(null);

        final inrate = await _currencyService.getrate();
        final results = SearchDto.fromdetaildto(
          EbuyItemsDetails.fromjson(raw),
          inrate,
        ).toDomain();
        addcacheitem(itemId, results);
        return Result.onSuccess(bottomcache[itemId]);
      }
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  @override
  Future<Result<void>> updateQuantity(String itemid, int quantity) async {
    final istemexist = cartcache.containsKey(itemid);
    if (!istemexist) {
      bottomcache[itemid]?.quantity = quantity;
      cartcache[itemid]?.quantity = quantity;
    } else {
      bottomcache[itemid]?.quantity = quantity;
      cartcache[itemid]?.quantity = quantity;

      return await db.updatequantity(itemid, quantity);
    }
    return Result.onSuccess(null);
  }

  @override
  List<SearchDomain> getcartlist() {
    return cartcache.values.toList();
  }

  @override
  Future<Result<void>> deleteitem(String itemId) async {
    cartcache.remove(itemId);
    bottomcache.remove(itemId);

    return await db.deleteItem(itemId);
  }

  @override
  Future<Result<bool>> clearCart() async {
    final result = await db.clearCart();
    if (result.isFailure) {
      Result.onfailure(result.error);
    }
    if (result.isSuccess) {
      bottomcache.clear();
      cartcache.clear();
      return Result.onSuccess(result.data ?? false);
    }
    return Result.onSuccess(false);
  }
}
