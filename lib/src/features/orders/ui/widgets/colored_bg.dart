import 'package:flutter/material.dart';

class ColoredBg extends StatelessWidget {
  final double radius;
  final Widget child;
  final Color color;
  const ColoredBg({
    super.key,
    required this.radius,
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: Wrap(children: [child],),
    );
  }
}
