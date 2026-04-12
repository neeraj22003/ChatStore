import 'package:flutter/material.dart';

class BottomsheetProvider extends ChangeNotifier {
  static final Map<String, int?> _quantity = {};
  int quantity(String itemid) => _quantity[itemid] ?? 0;
  bool _expanded = false;
  bool get expanded => _expanded;

  double lastwidth = 0;

  void addwidth(double width, BuildContext context) {
    if (lastwidth != 0 && lastwidth != width) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      });
    }
    lastwidth = width;
  }

  void reset() {
    _expanded = false;
  }

  void addfucntion(String itemid) {
    _quantity[itemid] = (_quantity[itemid] ?? 0) + 1;
    notifyListeners();
  }

  void subfuction(String itemid) {
    if ((_quantity[itemid] ?? 0) > 0) {
      _quantity[itemid] = _quantity[itemid]! - 1;
    }
    notifyListeners();
  }

  void onpress() {
    _expanded == false ? _expanded = true : _expanded = false;
    notifyListeners();
  }
}
