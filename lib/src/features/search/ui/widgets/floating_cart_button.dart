import 'package:flutter/material.dart';


import 'package:flutter_experiments/features/cart/ui/providers/cart_provider.dart';
import 'package:flutter_experiments/core/layout/providers/navigation_provider.dart';
import 'package:provider/provider.dart';

class FloatingCartButton extends StatelessWidget {
  const FloatingCartButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer2<CartProvider, NavigationProvider>(
      builder: (context, cartprovider, naviprovider, child) {
        final theme = Theme.of(context).colorScheme;
        if (naviprovider.selectedindex == 0) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              FloatingActionButton(
                backgroundColor: theme.brightness == Brightness.light
                    ? theme.primary
                    : theme.surfaceContainerHighest,
                onPressed: () {
                  if (cartprovider.cartitem.values.isNotEmpty) {
                    
                   /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );*/
                    naviprovider.openendrawer(true);
                  } else {
                    null;
                  }
                },
                child: Icon(
                  Icons.shopping_bag,
                  color: cartprovider.cartitem.values.isNotEmpty
                      ? Colors.white
                      : Colors.grey,
                ),
              ),
              Positioned(
                left: -7,
                bottom: -4,
                child: CircleAvatar(
                  radius: 12,

                  child: Center(
                    child: Text(
                      '${cartprovider.cartitem.values.toList().length}',
                      // style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
