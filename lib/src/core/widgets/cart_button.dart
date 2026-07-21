import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  final VoidCallback ontap;
  const CartButton({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: ontap,
      child: Icon(Icons.shopping_bag),
    );
  }
}
