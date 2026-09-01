import 'package:flutter/material.dart';


class GoogleLinkWidget extends StatelessWidget {
  final String leadingImage;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback onTap;
  const GoogleLinkWidget({
    super.key,
    required this.leadingImage,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap
  });

  Widget leading() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Image.asset(
        leadingImage,
        height: 40,
        cacheHeight: 100,
        cacheWidth: 100,
      ),
    );
  }

  Widget titleWidget() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Text(
        title,
        
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget subtitleWidget() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Text(
        subtitle,
         
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Material(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.all(6),
          leading: leading(),
          title: titleWidget(),
          subtitle: subtitleWidget(),
          trailing: trailing,
        ),
      ),
    );
  }
}
