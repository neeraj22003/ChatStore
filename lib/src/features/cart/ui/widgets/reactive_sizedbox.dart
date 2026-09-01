import 'dart:math';

import 'package:flutter/widgets.dart';

class ReactiveSizedbox extends StatelessWidget {
  final ValueNotifier<int> youritemlengthNotifier;
  final Widget child;
  final double itemheight;
  const ReactiveSizedbox({
    super.key,
    required this.youritemlengthNotifier,
    required this.child,
    required this.itemheight,
  });
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: youritemlengthNotifier,
      builder: (context, value, _) {
        if (value > 0) {
          return SizedBox(height: min(itemheight * value, 300), child: child);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
