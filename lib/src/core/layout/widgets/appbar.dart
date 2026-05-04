import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_shop/src/features/user/ui/provider/provider.dart';
import 'package:flutter/material.dart';


import 'package:chat_shop/src/core/layout/providers/navigation_provider.dart';

import 'package:chat_shop/src/features/cart/ui/providers/cart_provider.dart';
import 'package:path/path.dart';

import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Widget build(BuildContext context) {
   
    return Consumer3<Userprovider, CartProvider, NavigationProvider>(
      builder: (context, provider, auth, navi, child) {
        return AppBar(
          backgroundColor: Colors.white,
          title: Text('Store', style: TextStyle(fontWeight: FontWeight.w700)),
          
          actions: [
           const SizedBox(width: 4),
            IconButton(
              onPressed: () {
                navi.openendrawer(false);
              },
              icon:provider.userDomain?.profileimage!=null
              ?CircleAvatar(radius: 15,
                backgroundImage:CachedNetworkImageProvider( provider.userDomain!.profileimage!)
              ) :const Icon(Icons.person),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
