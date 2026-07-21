import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double? padding;
  const CustomDivider({super.key, this.padding});
  @override
  Widget build(BuildContext context) {
    return padding != null
        ? Padding(
            padding: EdgeInsets.only(left: padding!, right: padding!),
            child: Divider(),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Divider(),
          );
  }
}
