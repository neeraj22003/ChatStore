
import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/currency_service/currency_service.dart';
import 'package:chat_shop/src/core/items/data/ebay_service.dart';

import 'package:chat_shop/src/core/items/data/ebayitem_dto.dart';
import 'package:chat_shop/src/core/items/data/search_dto.dart';
import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:chat_shop/src/features/search/domain/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final EbuyService _dataSource;
  final CurrencyService _currencyservice;
 

  SearchRepoImpl(this._dataSource, this._currencyservice);

  
 
  

  @override
  Future<Result<List<SearchDomain>>> searchItems(String? query) async {
    try {
      if (query != null) {
        final raw = await _dataSource.ebayservice(query, null);
        if (raw == null) return Result.onSuccess([]);

        final inrrate = await _currencyservice.getrate();
        final results = raw.map((data) {
          final searchdomain = SearchDto.fromListdto(
            EbuyItemsModel.fromJson(data),
            inrrate,
          ).toDomain();
          return searchdomain;
        }).toList();
        return Result.onSuccess(results);
      } else {
        return Result.onSuccess([]);
      }
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  @override
  Future<Result<List<SearchDomain>>> feeditems() async {
    try {
      final raw = await _dataSource.ebayservice(null, null);
      if (raw == null) return Result.onSuccess([]);
      final inrate = await _currencyservice.getrate();
      final results = raw.map((data) {
        final searchdomain = SearchDto.fromListdto(
          EbuyItemsModel.fromJson(data),
          inrate,
        ).toDomain();
        return searchdomain;
      }).toList();
      return Result.onSuccess(results);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  @override
  Future<Result<List<SearchDomain>>> getcategoryitem(String? id) async {
    try {
      if (id != null) {
        final raw = await _dataSource.ebayservice(null, id);
        if (raw == null) return Result.onSuccess([]);

        final inrrate = await _currencyservice.getrate();
        final results = raw.map((data) {
          final seachdomain = SearchDto.fromListdto(
            EbuyItemsModel.fromJson(data),
            inrrate,
          ).toDomain();

          return seachdomain;
        }).toList();
        return Result.onSuccess(results);
      } else {
        return Result.onSuccess([]);
      }
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  
}
