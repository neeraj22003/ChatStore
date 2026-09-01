import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomUsercard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String userImage;
  final Widget? trailing;
  final String placeholder;
  final VoidCallback onTap;
  
  const CustomUsercard({
    super.key,
    required this.title,
    required this.placeholder,
    required this.subtitle,
    required this.userImage,
    required this.onTap,
    this.trailing,
  });
  Widget customTitle(String name, double size1, double size2, double width) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: width < 373 ? size1 : size2),
      ),
    );
  }

  Widget profile(ColorScheme color, double width) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        backgroundColor: color.primary,
        radius: width < 258 ? 17 : 26,
        child: CircleAvatar(
          radius: width < 258 ? 15 : 24,
          backgroundImage: userImage.isEmpty
              ? AssetImage(placeholder)
              : CachedNetworkImageProvider(userImage),
        ),
      ),
    );
  }

  Widget heading(ColorScheme color, double width) {
    return Expanded(
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 4, top: 1, bottom: 1),
        title: customTitle(title, 13, 14, width),
        subtitle: customTitle(subtitle, 10, 13, width),
        trailing: Padding(
          padding: const EdgeInsets.all(8.0),
          child: trailing,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constrainst) {
        final count = max(1, constrainst.maxWidth ~/ 200);

        final cardwidth = (constrainst.maxWidth - 16) / count;
        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [profile(color, cardwidth), heading(color, cardwidth)],
            ),
          ),
        );
      },
    );
  }
}
