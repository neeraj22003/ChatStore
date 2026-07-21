import 'package:flutter/material.dart';

class TotalCart extends StatelessWidget {
  final ValueNotifier<int> yourcartlength;
  const TotalCart({super.key, required this.yourcartlength});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: yourcartlength,
      builder: (context, value, child) {
        return Text('Total Items: $value', style: TextStyle(fontSize: 11.5));
      },
    );
  }
}
