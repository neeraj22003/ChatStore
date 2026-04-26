import 'package:flutter/material.dart';
import 'package:chat_shop/src/features/cart/ui/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class LocationbottomSheet extends StatelessWidget {
  const LocationbottomSheet({super.key});

  Widget locationtile(
    String tilename,
    Widget icon,
    BuildContext context,
    void Function() function,
    String? checkerlocation,
    CartProvider cart,
  ) {
    final bool ismatch = cart.selectedlocation == checkerlocation;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        tileColor: Color.fromARGB(136, 167, 167, 167),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        leading: icon,
        title: Text(tilename),
        trailing: Icon(
          Icons.radio_button_checked_outlined,
          color: ismatch ? const Color.fromARGB(255, 28, 117, 190) : null,
        ),

        onTap: () {
          function();
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CartProvider>();
    final user = provider.user;

    return Wrap(
      children: [
        locationtile(
          'Use Current Location',
          Icon(Icons.location_on),
          context,
          () async {
            provider.onselectedlocation(provider.current);
          },
          provider.current,
          provider,
        ),

        locationtile(
          user?.address ?? 'Default Address',
          Icon(Icons.home),
          context,
          () => provider.onselectedlocation(user?.address ?? 'Default Address'),
          user?.address ?? 'Default Address',
          provider,
        ),
        const SizedBox(height: 140),
      ],
    );
  }
}

void locationsheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    clipBehavior: Clip.hardEdge,
    builder: (context) => LocationbottomSheet(),
  );
}
