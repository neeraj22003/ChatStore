import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_experiments/core/layout/providers/navigation_provider.dart';
import 'package:flutter_experiments/features/chats/data/chat_repository.dart';
import 'package:flutter_experiments/features/chats/ui/screen/chat_page.dart';
import 'package:flutter_experiments/features/chats/ui/providers/privider.dart';
import 'package:flutter_experiments/features/user/domain/user_domain.dart';

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
          backgroundImage: imageurl != null ? NetworkImage(imageurl) : null,
          child: imageurl == null ? Icon(Icons.person, size: 30) : null,
        ),
      ),
    );
  }

  Widget heading(String name, String email) {
    return Expanded(
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 4, top: 1, bottom: 1),
        title: customTitle(name, 13, 14),
        subtitle: customTitle(email, 10, 13),
        trailing: width < 195
            ? null
            : Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 2),
                child: const Icon(Icons.chat),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final navigation = context.watch<NavigationProvider>();
    final directuserdata = UserDomain.fromJson(
      user.data() as Map<String, dynamic>,
    );
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          final chatroomid = ChatRepository(null).getchatid(user.id);
          await chatProvider.getchatuser(
            user.data() as Map<String, dynamic>,
            chatroomid,
            user.id,
          );
          if (isdesktop) {
            navigation.ontapbottom(2);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  secondguyid: user.id,
                  secondguyname: directuserdata.name,
                  chatid: directuserdata.chatroonmId,
                  isDesktop: isdesktop,
                ),
              ),
            );
          }
        },
        child: Row(
          children: [
            profile(directuserdata.profileimage, color),
            heading(directuserdata.name, directuserdata.email),
          ],
        ),
      ),
    );
  }
}
