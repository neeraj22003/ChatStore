import 'package:flutter/material.dart';

class Customoutlinebutton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? color;
  const Customoutlinebutton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 2),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color ?? Colors.transparent, width: 2),
          backgroundColor: color,
        ),

        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
