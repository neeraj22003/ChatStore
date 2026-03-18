import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_experiments/features/cart/data/location_service.dart';
import 'package:flutter_experiments/features/search/data/search_dto.dart';

import 'package:flutter_experiments/features/search/domain/search_item_domain.dart';
import 'package:flutter_experiments/features/user/ui/provider/provider.dart';

class CartRepository {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> additem(SearchDomain item) async {
    await FirebaseFirestore.instance
        .collection('cart')
        .doc(userId)
        .collection('items')
        .doc(item.itemId)
        .set(item.toJson(), SetOptions(merge: true));
  }

  Future<void> cartToOrders(Map<String, SearchDomain> item) async {
    final user = Userprovider().userDomain!;
    final location = LocationService().location;
    final orderdata = {
      'name': user.name,
      'phone': user.phone,
      'address': location ?? user.address,
      'item': item,
    };
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(userId)
        .collection('userorders')
        .doc()
        .set(orderdata, SetOptions(merge: true));

    final cartdoc = await FirebaseFirestore.instance
        .collection('cart')
        .doc(userId)
        .collection('items')
        .get();
    for (var doc in cartdoc.docs) {
      if (doc.data().isNotEmpty) {
        doc.reference.delete();
      }
    }
    item.clear();
  }

  Future<List<SearchDomain>> loaditems() async {
    final cart = await FirebaseFirestore.instance
        .collection('cart')
        .doc(userId)
        .collection('items')
        .get();

    return cart.docs.map((item) {
      final dto = EbuyItemsDetails.fromjson(item.data());
      print(dto.price);
      return SearchDomain.fromdetaildto(dto, null);
    }).toList();
  }
}
