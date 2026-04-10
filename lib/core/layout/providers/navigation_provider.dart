import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedindex = 0;
  int get selectedindex => _selectedindex;

  bool _iscart = true;
  bool get iscart => _iscart;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  void openendrawer(bool bool) {
    _iscart = bool;
    notifyListeners();
    scaffoldkey.currentState!.openEndDrawer();
  }

  void closedrwaer(bool bool) {
    _iscart = bool;
    notifyListeners();
    scaffoldkey.currentState?.closeEndDrawer();
  }

  void ontapbottom(int index) {
    _selectedindex = index;
    notifyListeners();
  }
}
