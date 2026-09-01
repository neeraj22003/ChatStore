import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class OrderCard extends StatelessWidget {
  final String appname;
  final String appIconImg;
  final List<String> images;
  final VoidCallback onPressed;
  const OrderCard({
    super.key,
    required this.appname,
    required this.appIconImg,
    required this.images,
    required this.onPressed
  });

  Widget brandheader() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8),
      child: Row(
        children: [
          SizedBox(height: 20, width: 20, child: Image.asset(appIconImg)),
          const SizedBox(width: 5),
          Text(
            appname,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget imagelist(ColorScheme color) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: color.surfaceContainerHighest,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              child: CachedNetworkImage(imageUrl: images[i], fit: BoxFit.cover,errorWidget:(context, url, error) => const Icon(Icons.broken_image) ,),
            ),
          ),
        ),
      ),
    );
  }

  Widget button(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_circle_right_outlined, size: 35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(onTap: onPressed,child:  Material(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      color: theme.surfaceContainer,
      child: Column(
        children: [brandheader(), imagelist(theme), button(context)],
      ),
    ));
  }
}
