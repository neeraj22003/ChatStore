import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:chat_shop/src/features/cart/data/cart_repository.dart';
import 'package:chat_shop/src/features/cart/data/location_service.dart';
import 'package:chat_shop/src/features/orders/data/orders_repositry.dart';
import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';

import 'package:chat_shop/src/features/search/data/search_dto.dart';
import 'package:chat_shop/src/features/search/data/search_repo.dart';

import 'package:chat_shop/src/features/search/domain/search_item_domain.dart';
import 'package:chat_shop/src/features/user/domain/user_domain.dart';

class CartProvider extends ChangeNotifier {
  UserDomain? user;
  CartProvider(this.user);

  Map<String, SearchDomain> _cartitems = {};
  Map<String, SearchDomain> get cartitem => _cartitems;

  String? _selectedlocation;
  String? get selectedlocation => _selectedlocation;
  bool _isloading = false;
  bool get isloading => _isloading;
  String? _current;
  String? get current => _current;

  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  void init() async {
    await loaditems();
    injectuseraddress();
  }

  void injectuseraddress() {
    _selectedlocation = user?.address;
  }

  void onselectedlocation(String? location) async {
    if (location == null) {
      _isloading = true;
      notifyListeners();
      final loc = await LocationService().fetcher();
      _selectedlocation = loc;
      _current = loc;
      _isloading = false;
      notifyListeners();
    }
    if (location != null) {
      _selectedlocation = location;
    }
    notifyListeners();
  }

  void additem(SearchDomain item) async {
    _cartitems[item.itemId] = item;
    notifyListeners();
    if (userId != null) {
      await CartRepository().additem(item, userId);
    }
  }

  double get totalprice {
    double total = 0.0;
    _cartitems.forEach((key, item) {
      total += (item.inrprice! * item.quantity);
    });
    return total;
  }

  void quantity(int? quantity, EbuyItemsModel itemid) {
    _cartitems[itemid.itemId]?.quantity = quantity!;
    notifyListeners();
  }

  Future<void> loaditems() async {
    final item = await CartRepository().loaditems(userId);

    _cartitems = Map.fromEntries(
      item.map((data) {
        SearchRepo().addcacheitem(data.itemId, data);
        return MapEntry(data.itemId, data);
      }),
    );

    notifyListeners();
  }

  Future<void> placeOrder(BuildContext context, String total) async {
    final orderrepo = OrdersRepositry();
    if (userId != null) {
      final itemlist = _cartitems.values.map((data) => data.toJson()).toList();

      final order = Orders(
        orderId: '',
        name: user?.name ?? '',
        phone: user?.phone ?? '',
        address: selectedlocation ?? user?.address ?? "",
        total: total,
        items: itemlist,
      );
      await orderrepo.addOrders(order, userId, context);
    }

    _cartitems.clear();
    SearchRepo().cache.clear();
    notifyListeners();
  }
}
