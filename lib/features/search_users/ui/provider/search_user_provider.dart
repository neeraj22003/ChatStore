import 'package:flutter/material.dart';

class SearchUserProvider extends ChangeNotifier {
  final TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;

  void onsubmit() {
    notifyListeners();
  }

  void clearfield() {
    _controller.clear();
    notifyListeners();
  }
}
