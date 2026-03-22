import 'package:flutter_experiments/core/services/currency_service.dart';
import 'package:flutter_experiments/features/search/data/search_data_source.dart';
import 'package:flutter_experiments/features/search/data/search_dto.dart';
import 'package:flutter_experiments/features/search/domain/search_item_domain.dart';

class SearchRepo {
  static final SearchRepo _instance = SearchRepo.internal();
  factory SearchRepo() => _instance;
  SearchRepo.internal();
  final SearchDataSource _dataSource = SearchDataSource();

  final _currencyservice = CurrencyService();
  Map<String, SearchDomain> cache = {};

  void addcacheitem(String key, SearchDomain item) {
    if (cache.length >= 6) {
      final firstitem = cache.keys.first;
      cache.remove(firstitem);
    }
    cache[key] = item;
  }

  Future<List<SearchDomain>> searchItems(String query) async {
    final raw = await _dataSource.searchItems(query);
    if (raw == null) return [];

    final inrrate = await _currencyservice.getrate();
    return raw.map((data) {
      return SearchDomain.fromListdto(EbuyItemsModel.fromJson(data), inrrate);
    }).toList();
  }

  Future<SearchDomain?> getdetails(String itemId) async {
    if (cache.containsKey(itemId)) {
      return cache[itemId];
    } else {
      final raw = await _dataSource.itemDetails(itemId);
      if (raw == null) return null;
      final inrate = await _currencyservice.getrate();
      return SearchDomain.fromdetaildto(EbuyItemsDetails.fromjson(raw), inrate);
    }
  }
}
