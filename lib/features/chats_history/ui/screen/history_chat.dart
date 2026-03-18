import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_experiments/features/chats/ui/screen/chat_page.dart';
import 'package:flutter_experiments/features/chats_history/ui/providers/privider.dart';
import 'package:provider/provider.dart';

class AdaptiveHistoryPage extends StatelessWidget {
  const AdaptiveHistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isdesktop = width >= 480;
    if (isdesktop) {
      return Row(
        children: [
          Expanded(
            child: HistoryChatPage(isdesktop: isdesktop, width: width),
          ),
          VerticalDivider(thickness: 2, width: 2),
          Consumer<ChatProvider>(
            builder: (context, provider, child) => Expanded(
              child: provider.id != null
                  ? ChatPage(
                      secondguyid: provider.id!,
                      secondguyname: provider.title!,
                      chatid: provider.chatid!,
                      isDesktop: isdesktop,
                    )
                  : Center(child: Text('No chats')),
            ),
          ),
        ],
      );
    }
    return HistoryChatPage(isdesktop: isdesktop, width: width);
  }
}

class HistoryChatPage extends StatelessWidget {
  final bool isdesktop;
  final double width;
  const HistoryChatPage({
    super.key,
    required this.isdesktop,
    required this.width,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> chatlist() {
    final myId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('messages')
        .where('participants', arrayContains: myId)
        .snapshots();
  }

  Widget chatcard(
    BuildContext context,
    ColorScheme color,
    String titl,
    String lastmessafe,
    String id,
    String chatid,
  ) {
    final provider = context.watch<ChatProvider>();

    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      clipBehavior: Clip.hardEdge,
      color: provider.chatid == chatid ? color.surfaceContainerHighest : null,
      child: InkWell(
        onTap: () {
          if (isdesktop) {
            provider.addChatidTilereciverid(id, titl, chatid);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  secondguyid: id,
                  secondguyname: titl,
                  chatid: chatid,
                  isDesktop: isdesktop,
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
                  child: Icon(Icons.person, size: 40),
                ),
              ),
            ),
            Expanded(
              child: ListTile(title: Text(titl), subtitle: Text(lastmessafe)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return StreamBuilder(
      stream: chatlist(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Messages Yet'));
        }
        final doc = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(6),
          itemCount: doc.length,
          itemBuilder: (context, index) {
            final data = doc[index].data();
            final isme = FirebaseAuth.instance.currentUser?.uid;

            final title = data['senderId'] == isme
                ? data['receiver']
                : data['sender'];
            final chatid = doc[index].id;
            final id = data['receiverId'];
            return chatcard(
              context,
              color,
              title,
              data['lastMessage'] ?? 'me',
              id,
              chatid,
            );
          },
        );
      },
    );
  }
}
