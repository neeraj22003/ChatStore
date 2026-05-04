import 'package:flutter/material.dart';
import 'package:chat_shop/src/features/search/domain/search_item_domain.dart';
import 'package:chat_shop/src/features/search/ui/provider/bottomsheet_provider.dart';

import 'package:chat_shop/src/features/cart/ui/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class Additionbuttonlist extends StatelessWidget {
  final SearchDomain item;
  
  const Additionbuttonlist({super.key, required this.item});
  Widget addbutton(BottomsheetProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: IconButton(
        onPressed: () {
          provider.addfucntion(item.itemId);
        },
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget subutton(BottomsheetProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: IconButton(
        onPressed: () {
          provider.subfuction(item.itemId);
        },
        icon: const Icon(Icons.remove),
      ),
    );
  }

  Widget numcontainer(
    ColorScheme colorScheme,
    BottomsheetProvider provider,
    SearchDomain modal,
  ) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.all(const Radius.circular(2)),
      ),
      child: SizedBox(
        height: 25,
        width: 25,
        child: Center(
          child: Text('${provider.quantity(modal.itemId) + item.quantity}'),
        ),
      ),
    );
  }

  Widget addTocartbutton(
    ColorScheme colorScheme,

    CartProvider provider,
    BottomsheetProvider bottomprovider,

    BuildContext context,
  ) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          colorScheme.surfaceContainerHighest,
        ),
      ),
      onPressed: () {
        item.quantity = bottomprovider.quantity(item.itemId);
        provider.additem(item);

        // bottomprovider.reset();
        Navigator.pop(context);
      },
      child: const Text('Add to Cart'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Consumer2<BottomsheetProvider, CartProvider>(
      builder: (context, bottom, cart, child) {
        return Row(
          children: [
            subutton(bottom),
            numcontainer(color, bottom, item),
            addbutton(bottom),
            Spacer(),
            addTocartbutton(color, cart, bottom, context),
          ],
        );
      },
    );
  }
}
