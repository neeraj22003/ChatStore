import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_experiments/features/cart/data/cart_repository.dart';
import 'package:flutter_experiments/features/orders/data/orders_repositry.dart';
import 'package:flutter_experiments/features/orders/domain/orderdomain.dart';

import 'package:flutter_experiments/features/search/data/search_dto.dart';
import 'package:flutter_experiments/features/search/data/search_repo.dart';

import 'package:flutter_experiments/features/search/domain/search_item_domain.dart';
import 'package:flutter_experiments/features/user/domain/user_domain.dart';

class CartProvider extends ChangeNotifier {
  final UserDomain? user;
  CartProvider(this.user);
  Map<String, SearchDomain> _cartitems = {};
  Map<String, SearchDomain> get cartitem => _cartitems;

  String? _selectedlocation;
  String? get selectedlocation => _selectedlocation;
  bool _isloading = false;
  bool get isloading => _isloading;
  Timer? _timer;
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> init() async {
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
    if (userId != null) return;
    final item = await CartRepository().loaditems(userId);
    _cartitems = Map.fromEntries(
      item.map((data) {
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
        address: user?.address ?? "",
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
