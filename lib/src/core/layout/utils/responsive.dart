import 'package:flutter/material.dart';

class LayoutUtils {
  static bool isBigScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 480;
  }
}
