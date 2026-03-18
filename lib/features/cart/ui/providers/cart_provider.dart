import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_experiments/features/cart/data/cart_repository.dart';

import 'package:flutter_experiments/features/search/data/search_dto.dart';
import 'package:flutter_experiments/features/orders/ui/providers/order_provider.dart';
import 'package:flutter_experiments/features/search/domain/search_item_domain.dart';

class CartProvider extends ChangeNotifier {
  Map<String, SearchDomain> _cartitems = {};
  Map<String, SearchDomain> get cartitem => _cartitems;

  String? _selectedlocation;
  String? get selectedlocation => _selectedlocation;
  bool _isloading = false;
  bool get isloading => _isloading;
  Timer? _timer;

  CartProvider() {
    _init();
  }

  Future<void> _init() async {
    await loaditems();
  }

  void onselectedlocation(String location) {
    //this funcytion
    _selectedlocation = location;
    notifyListeners();
  }

  void loadingsetter() {
    _timer?.cancel();
    _isloading = true;
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _isloading = false;
      notifyListeners();
    });
  }

  void additem(SearchDomain item) async {
    _cartitems[item.itemId] = item;
    await CartRepository().additem(item);
    notifyListeners();
  }

  double get totalprice {
    double total = 0.0;
    _cartitems.forEach((key, item) {
      total += (item.inrprice! * item.quantity);
    });
    return total;
  }

  void reset(OrderProvider orderprovider) async {
    await CartRepository().cartToOrders(_cartitems);
    notifyListeners();
  }

  void quantity(int? quantity, EbuyItemsModel itemid) {
    _cartitems[itemid.itemId]?.quantity = quantity!;
    notifyListeners();
  }

  Future<void> loaditems() async {
    final item = await CartRepository().loaditems();
    _cartitems = Map.fromEntries(
      item.map((data) {
        return MapEntry(data.itemId, data);
      }),
    );

    notifyListeners();
  }
}
