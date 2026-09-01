
import 'package:flutter/material.dart';

class CartBottomSheet extends StatelessWidget {
  final List<Widget>children;
  const CartBottomSheet({super.key, required this.children});
  @override
  Widget build(BuildContext context) {
    return Material(

      elevation:16,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
    child: Wrap(alignment: .center,
      children:children,));
  }
}
