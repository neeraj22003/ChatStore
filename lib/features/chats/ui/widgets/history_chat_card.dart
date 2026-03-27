import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/chats/domain/chat_domain.dart';
import 'package:flutter_experiments/features/chats/ui/providers/privider.dart';
import 'package:flutter_experiments/features/chats/ui/screen/chat_page.dart';
import 'package:provider/provider.dart';

class HistoryChatCard extends StatelessWidget {
  final ChatDomain chatDomain;
  final String chatid;
  final bool isdesktop;
  final String? otherid;

  const HistoryChatCard({
    super.key,
    required this.chatDomain,
    required this.chatid,
    required this.isdesktop,
    required this.otherid,
  });
  String? title(String isme) {
    return chatDomain.senderId == isme
        ? chatDomain.receiver
        : chatDomain.sender;
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final isme = FirebaseAuth.instance.currentUser?.uid;

    return Consumer<ChatProvider>(
      builder: (context, provider, child) {
        return Material(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          clipBehavior: Clip.hardEdge,
          color: provider.chat?.chatroomid == chatid
              ? color.surfaceContainerHighest
              : null,
          child: InkWell(
            onTap: () {
              if (isdesktop) {
                provider.getchatuser(chatDomain, chatid);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      secondguyid: chatDomain.receiverId,
                      secondguyname: title(isme ?? ''),
                      chatid: chatid,
                      isDesktop: isdesktop,
                      chatprovider: provider,
                    ),
                  ),
                );
              }
            },

            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: color.primary,
                    radius: 27,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: CachedNetworkImageProvider(
                        provider.users?[otherid]?.profileimage ?? '',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(title(isme ?? '') ?? ''),
                    subtitle: Text(chatDomain.lastmessage ?? ''),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
