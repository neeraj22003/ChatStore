import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';

class Orders {
  final String orderId;
  final String name;
  final String phone;
  final String address;
  final String total;
  final List<SearchDomain> items;
  Orders({
    required this.orderId,
    required this.name,
    required this.phone,
    required this.address,
    required this.total,
    required this.items,
  });
  
}
