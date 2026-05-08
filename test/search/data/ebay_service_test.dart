

import 'package:chat_shop/src/core/services/currency_service.dart';
import 'package:chat_shop/src/features/search/data/ebay_service.dart';
import 'package:chat_shop/src/features/search/data/search_repo.dart';

import 'package:test/test.dart';

void main() {
  final repo = SearchRepo(
    datasource: Mockserive(),
    currencyserrvice: FakeCurrencyService(),
  );
  test('itemisnot empty', () async {
    final item = await repo.feeditems();
    expect(item, isNotEmpty);
  });
  test('query', () async {
    final item = await repo.searchItems('ba');
    print((item.first.inrprice)?.toStringAsFixed(1));
    expect(item.first.title, equals('ball'));
  });
  test('catergory test', () async {
    final item = await repo.getcategoryitem('1003');
    expect(item.first.title, equals('gloves'));
  });
}

class Mockserive extends EbuyService {
  final testdata = [
    {
      "itemId": "125",
      "title": "ball",
      "price": {"value": "19.99", "currency": "USD"},
      "image": {"imageUrl": "imagesjfnsg"},
      "categoryId": "1001",
    },
    {
      "itemId": "125",
      "title": "bat",
      "price": {"value": "49.99", "currency": "USD"},
      "image": {"imageUrl": "imagesbat"},
      "categoryId": "1002",
    },
    {
      "itemId": "128",
      "title": "gloves",
      "price": {"value": "15.00", "currency": "USD"},
      "image": {"imageUrl": "imagesgloves"},
      "categoryId": "1003",
    },
    {
      "itemId": "128",
      "title": "helmet",
      "price": {"value": "35.50", "currency": "USD"},
      "image": {"imageUrl": "imageshelmet"},
      "categoryId": "1004",
    },
  ];
  @override
  Future<List<dynamic>?> ebayservice(String? query, String? categoryid) async {
    if (query != null) {
      return testdata
          .where(
            (data) => (data['title'] as String).toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
    } else if (categoryid != null) {
      return testdata
          .where((data) => data["categoryId"] == categoryid)
          .toList();
    } else {
      return testdata;
    }
  }
}

class FakeCurrencyService extends CurrencyService {
  @override
  Future<double> getrate() async {
    return 85.0; // pretend 1 USD = 85 INR
  }

  @override
  Future<void> init() async {
    // no-op for tests
  }
}
