import 'package:flutter/material.dart';
import 'package:chat_shop/src/core/services/images.dart';
import 'package:chat_shop/src/features/user/ui/provider/provider.dart';
import 'package:chat_shop/src/features/user/ui/widget/outlined_button.dart';

class GoogleLinkWidget extends StatelessWidget {
  final Userprovider provider;
  const GoogleLinkWidget({super.key, required this.provider});

  Widget leading() {
    return Image.asset(
      ImageService.google,
      height: 40,
      cacheHeight: 100,
      cacheWidth: 100,
    );
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Text(
        provider.islinked
            ? 'Google Account Linked'
            : 'Connect to Google Account',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget subtitle() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Text(
        provider.islinked
            ? 'Linked successfully — no further action needed'
            : 'Sync your account with Google',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  Widget trailing() {
    return provider.islinked
        ? Text("Linked", style: TextStyle(fontSize: 12, color: Colors.green))
        : Customoutlinebutton(
            onPressed: () async {
              await provider.linkwithGoogle();
            },
            text: 'Link',
            color: const Color(0xFFB71C1C),
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
          onTap: () async {
            if (!provider.islinked) {
              await provider.linkwithGoogle();
            }
          },
          contentPadding: const EdgeInsets.all(6),
          leading: Padding(padding: EdgeInsets.zero, child: leading()),
          title: title(),
          subtitle: subtitle(),
          trailing: trailing(),
        ),
      ),
    );
  }
}
