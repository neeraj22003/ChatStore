import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chat_shop/src/features/search/data/search_dto.dart';

import 'package:chat_shop/src/features/search/domain/search_item_domain.dart';

class CartRepository {
  Future<void> additem(SearchDomain item, String? userId) async {
    await FirebaseFirestore.instance
        .collection('cart')
        .doc(userId)
        .collection('items')
        .doc(item.itemId)
        .set(item.toJson(), SetOptions(merge: true));
  }

  Future<List<SearchDomain>> loaditems(String? userId) async {
    final cart = await FirebaseFirestore.instance
        .collection('cart')
        .doc(userId)
        .collection('items')
        .get();

    return cart.docs.map((item) {
      final dto = EbuyItemsDetails.fromjson(item.data());
      return SearchDomain.fromdetaildto(dto, null);
    }).toList();
  }
}
