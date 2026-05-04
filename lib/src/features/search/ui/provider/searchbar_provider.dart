import 'package:flutter/material.dart';

class SearchbarProvider extends ChangeNotifier {
  final TextEditingController _controller = TextEditingController();
  String? _categoryid;
  String? get id => _categoryid;

  String? _categoryname;
  String? get category => _categoryname;

  TextEditingController get controller => _controller;

  final ValueNotifier<bool> _categoryactive = ValueNotifier(false);
  ValueNotifier<bool> get categoryactive => _categoryactive;

  int? _selectedindex;
  int? get selectedindex => _selectedindex;

  void clearfield() {
    controller.clear();
    _categoryid = null;
    _categoryname = null;
    categoryactive.value = false;
    _selectedindex = null;
    notifyListeners();
  }

  void onsubmitted() async {
    notifyListeners();
  }

  void setidandName(String id, String title, int index) {
    _categoryid = id;
    _categoryname = title;
    categoryactive.value = true;
    _selectedindex = index;
    notifyListeners();
  }
}
