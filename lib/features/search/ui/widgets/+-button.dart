import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/search/data/search_repo.dart';
import 'package:flutter_experiments/features/search/domain/search_item_domain.dart';
import 'package:flutter_experiments/features/search/ui/provider/bottomsheet_provider.dart';

import 'package:flutter_experiments/features/cart/ui/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class Additionbuttonlist {
  Widget addbutton(BottomsheetProvider provider, String itemid) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: IconButton(
        onPressed: () {
          provider.addfucntion(itemid);
        },
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget subutton(BottomsheetProvider provider, String itemid) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: IconButton(
        onPressed: () {
          provider.subfuction(itemid);
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
        child: Center(child: Text('${provider.quantity(modal.itemId)}')),
      ),
    );
  }

  Widget addTocartbutton(
    ColorScheme colorScheme,
    SearchDomain item,
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
        SearchRepo().addcacheitem(item.itemId, item);
        item.quantity = bottomprovider.quantity(item.itemId);
        provider.additem(item);

        // bottomprovider.reset();
        Navigator.pop(context);
      },
      child: const Text('Add to Cart'),
    );
  }

  Widget build(BuildContext context, SearchDomain item) {
    final color = Theme.of(context).colorScheme;

    return Consumer2<BottomsheetProvider, CartProvider>(
      builder: (context, bottom, cart, child) {
        return Row(
          children: [
            subutton(bottom, item.itemId),
            numcontainer(color, bottom, item),
            addbutton(bottom, item.itemId),
            Spacer(),
            addTocartbutton(color, item, cart, bottom, context),
          ],
        );
      },
    );
  }
}
