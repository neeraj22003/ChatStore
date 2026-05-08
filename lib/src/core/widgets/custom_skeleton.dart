import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Customskeleten extends StatelessWidget {
  final double? height;
  final double width;
  final double borderadius;
  const Customskeleten({super.key, required this.height, required this.width,
  required this.borderadius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child:  Padding(
        padding: const EdgeInsets.all(0.5),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 182, 182, 182),
            borderRadius: BorderRadius.all( Radius.circular(borderadius)),
          ),
          child: SizedBox(height: height, width: width),
        ),
      ),
    );
  }
}
