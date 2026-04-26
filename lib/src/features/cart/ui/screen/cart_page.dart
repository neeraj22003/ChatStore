import 'dart:math';

import 'package:flutter/material.dart';
import 'package:chat_shop/src/core/layout/providers/navigation_provider.dart';
import 'package:chat_shop/src/features/cart/ui/widgets/cart_item.dart';
import 'package:chat_shop/src/features/cart/ui/widgets/cart_bottomsheet.dart';
import 'package:chat_shop/src/features/cart/ui/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  Widget heading() {
    return Text(
      'Your Cart Items',
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 40,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget cartlist(CartProvider provider, ColorScheme color) {
    final details = provider.cartitem.values.toList();
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        height: 300,

        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: BoxBorder.all(width: 2, color: color.outlineVariant),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int count = max(1, constraints.maxWidth ~/ 264);
            return GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: details.length > 1 ? count : 1,
                mainAxisSpacing: 8,
                crossAxisSpacing: 15,
                mainAxisExtent: 80,
              ),
              itemCount: details.length,
              itemBuilder: (context, index) {
                return CartItem(details: details[index]);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, cart, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => cart.closedrwaer(true),
          ),
        ),
        body: Consumer<CartProvider>(
          builder: (context, provider, child) {
            final color = Theme.of(context).colorScheme;
            return Center(
              child: Column(children: [heading(), cartlist(provider, color)]),
            );
          },
        ),
        bottomSheet: CartBottomSheet(),
      ),
    );
  }
}
