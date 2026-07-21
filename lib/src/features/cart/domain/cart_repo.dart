import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:chat_shop/src/core/result/result_domain.dart';

abstract class CartRepositry {
  Future<Result<String?>> getlocation();
}
