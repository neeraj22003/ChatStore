import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/cart/ui/widgets/location_sheet.dart';

import 'package:flutter_experiments/features/cart/ui/providers/cart_provider.dart';
import 'package:flutter_experiments/core/layout/providers/navigation_provider.dart';
import 'package:flutter_experiments/features/orders/ui/providers/order_provider.dart';
import 'package:flutter_experiments/features/user/ui/provider/provider.dart';

import 'package:provider/provider.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});
  Widget sheetheading(
    MediaQueryData media,
    CartProvider cart,
    BuildContext context,
  ) {
    final user = context.read<Userprovider>();

    return Padding(
      padding: const EdgeInsets.all(7),
      child: Row(
        children: [
          Icon(Icons.home, size: media.size.width < 179 ? 20 : 30),
          Text(
            'Home-',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: media.size.width < 179 ? 6 : 13,
            ),
          ),
          Expanded(
            child: Text(
              cart.selectedlocation == null
                  ? user.userDomain?.address ?? ''
                  : cart.selectedlocation ?? '',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            onPressed: () {
              locationsheet(context);
            },
            child: cart.isloading
                ? CircularProgressIndicator()
                : Text(
                    'Change',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: media.size.width < 224 ? 10 : 12,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget rowitem(
    CartProvider provider,
    ColorScheme color,
    MediaQueryData media,
    OrderProvider order,
    BuildContext context,
    NavigationProvider navigation,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7),
      child: ElevatedButton(
        onPressed: () {
          provider.reset(order);
          navigation.ontapbottom(2);
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(12),
          backgroundColor: Color(0xFF1E90FF),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
        ),

        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '₹${provider.totalprice}'
                  '',
                  style: TextStyle(
                    fontSize: media.size.width < 195 ? 8 : 18,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'TOTAL',
                  style: TextStyle(
                    fontSize: media.size.width < 195 ? 7 : 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Spacer(),

            Text(
              'Place Order',
              style: TextStyle(
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
                fontSize: media.size.width < 224 ? 8 : 20,
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final theme = Theme.of(context).colorScheme;
    return Consumer3<CartProvider, OrderProvider, NavigationProvider>(
      builder: (context, provider, order, navigation, child) {
        return Container(
          height: 170,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: theme.brightness == Brightness.light
                    ? Colors.grey
                    : Colors.transparent,
                spreadRadius: 1,
              ),
            ],
            color: theme.surfaceContainer,
            borderRadius: BorderRadius.zero,
          ),
          child: Column(
            children: [
              sheetheading(media, provider, context),

              rowitem(provider, theme, media, order, context, navigation),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
