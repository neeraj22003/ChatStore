import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final Color? color;
  final String? image;
  final String? placeholderImage;

  const CircleImage({super.key,this.color, required this.image, required this.placeholderImage});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: color,
      child: CircleAvatar(
        radius: 22,
        backgroundImage: (image == null || image!.isEmpty)
            ? AssetImage(placeholderImage!)
            : CachedNetworkImageProvider(image??'',errorListener: (p0) => Icons.broken_image,),
      ),
    );
  }
}
