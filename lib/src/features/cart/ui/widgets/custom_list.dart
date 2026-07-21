import 'package:chat_shop/src/features/cart/ui/widgets/reactive_sizedbox.dart';
import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final ValueNotifier<int> itemnotifier;
  final int itemlength;
  final Widget? Function(BuildContext, int) itemBuilder;
  const CustomList({
    super.key,
    required this.itemBuilder,
    required this.itemlength,    required this.itemnotifier
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveSizedbox(
      youritemlengthNotifier: itemnotifier,
      itemheight: 60,
      child: ListView.builder(itemCount: itemlength, itemBuilder: itemBuilder),
    );
  }
}
