import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String yourHeading;
  const Heading({super.key,required this.yourHeading});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Text(
            yourHeading,
            style: TextStyle(
              fontSize: 49,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..color = const Color.fromARGB(255, 219, 150, 173)
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2,
            ),
          ),
          Text(
            yourHeading,
            style: TextStyle(
              fontSize: 49,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 137, 203, 221),
            ),
          ),
        ],
      ),
    );
  }
}
