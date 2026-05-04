import 'package:chat_shop/src/core/services/currency_service.dart';
import 'package:chat_shop/src/features/search/data/ebay_service.dart';

import 'package:chat_shop/src/features/search/data/search_dto.dart';
import 'package:chat_shop/src/features/search/domain/search_item_domain.dart';

class SearchRepo {
  static final SearchRepo _instance = SearchRepo.internal();
  factory SearchRepo() => _instance;
  SearchRepo.internal();
  final _dataSource = EbuyService();

  final _currencyservice = CurrencyService();
  Map<String, SearchDomain> cache = {};

  void addcacheitem(String key, SearchDomain item) {
    if (cache.length >= 6) {
      final firstitem = cache.keys.first;
      cache.remove(firstitem);
    }
    cache[key] = item;
  }

  Future<List<SearchDomain>> searchItems(String? query) async {
    if (query != null) {
      final raw = await _dataSource.searchItems(query);
      if (raw == null) return [];

      final inrrate = await _currencyservice.getrate();
      return raw.map((data) {
        return SearchDomain.fromListdto(EbuyItemsModel.fromJson(data), inrrate);
      }).toList();
    }
    return [];
  }

  Future<List<SearchDomain>?> getcategoryitem(String? id) async {
    if (id != null) {
      final raw = await _dataSource.getCategoryITems(id);
      if (raw == null) return [];

      final inrrate = await _currencyservice.getrate();
      return raw.map((data) {
        return SearchDomain.fromListdto(EbuyItemsModel.fromJson(data), inrrate);
      }).toList();
    }
    return null;
  }

  Future<SearchDomain?> getdetails(String itemId) async {
    if (cache.containsKey(itemId)) {
      return cache[itemId];
    } else {
      final raw = await _dataSource.itemDiscription(itemId);
      if (raw == null) return null;

      final inrate = await _currencyservice.getrate();
      addcacheitem(
        itemId,
        SearchDomain.fromdetaildto(EbuyItemsDetails.fromjson(raw), inrate),
      );
      return SearchDomain.fromdetaildto(EbuyItemsDetails.fromjson(raw), inrate);
    }
  }
}
