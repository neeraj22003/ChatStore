import 'package:flutter/material.dart';

class NormalHeading extends StatelessWidget {
  final String yourheading;
  const NormalHeading({super.key, required this.yourheading});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        yourheading,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
