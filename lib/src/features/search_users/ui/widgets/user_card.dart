import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:chat_shop/src/core/layout/providers/navigation_provider.dart';
import 'package:chat_shop/src/core/services/images.dart';
import 'package:chat_shop/src/features/chats/data/chat_repository.dart';
import 'package:chat_shop/src/features/chats/domain/chat_domain.dart';
import 'package:chat_shop/src/features/chats/ui/screen/chat_page.dart';
import 'package:chat_shop/src/features/chats/ui/providers/privider.dart';
import 'package:chat_shop/src/features/search_users/domain/searchuser_domain.dart';

import 'package:provider/provider.dart';

class UserCard extends StatelessWidget {
  final QueryDocumentSnapshot user;
  final bool isdesktop;
  final double width;
  final ChatProvider chatProvider;
  const UserCard({
    super.key,
    required this.user,
    required this.isdesktop,
    required this.width,
    required this.chatProvider,
  });

  Widget customTitle(String name, double size1, double size2) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: width < 373 ? size1 : size2),
      ),
    );
  }

  Widget profile(String? imageurl, ColorScheme color) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        backgroundColor: color.primary,
        radius: width < 258 ? 17 : 26,
        child: CircleAvatar(
          radius: width < 258 ? 15 : 24,
          backgroundImage: imageurl == null
              ? AssetImage(ImageService.placeholder)
              : CachedNetworkImageProvider(imageurl),
        ),
      ),
    );
  }

  Widget heading(String name, String email, String? myid, ColorScheme color) {
    return Expanded(
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 4, top: 1, bottom: 1),
        title: customTitle(name, 13, 14),
        subtitle: customTitle(email, 10, 13),
        trailing: width < 195
            ? null
            : Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 2),
                child: Icon(
                  Icons.chat,
                  color: user.id == myid ? color.surfaceContainerHighest : null,
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final navigation = context.watch<NavigationProvider>();
    final me = FirebaseAuth.instance.currentUser?.uid;
    final directuserdata = SearchuserDomain.fromJson(
      user.data() as Map<String, dynamic>,
    );
    chatProvider.users?[directuserdata.id]?.profileimage =
        directuserdata.profileimage;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          if (user.id == me) {
          } else {
            final chatroomid = ChatRepository(
              FirebaseAuth.instance.currentUser,
            ).getchatid(user.id);
            final chatDomain = ChatDomain(
              userid: user.id,
              username: directuserdata.name,
              chatroomid: chatroomid,
            );
            await chatProvider.getchatuser(chatDomain);
            if (isdesktop) {
              navigation.ontapbottom(2);
            } else {
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      secondguyid: user.id,
                      secondguyname: directuserdata.name,
                      chatid: chatroomid,
                      isDesktop: isdesktop,
                      profileimage: directuserdata.profileimage,
                    ),
                  ),
                );
              }
            }
          }
        },
        child: Row(
          children: [
            profile(directuserdata.profileimage, color),
            heading(directuserdata.name, directuserdata.email, me, color),
          ],
        ),
      ),
    );
  }
}
