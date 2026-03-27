import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/chats/data/chat_repository.dart';
import 'package:flutter_experiments/features/chats/domain/chat_domain.dart';

import 'package:flutter_experiments/features/chats/ui/screen/chat_page.dart';
import 'package:flutter_experiments/features/chats/ui/providers/privider.dart';
import 'package:flutter_experiments/features/chats/ui/widgets/history_chat_card.dart';

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
            builder: (context, provider, child) {
              final chat = provider.chat;
              return Expanded(
                child: chat != null
                    ? ChatPage(
                        secondguyid: chat.receiverId,
                        secondguyname: chat.receiver,
                        chatid: chat.chatroomid,
                        isDesktop: isdesktop,
                        chatprovider: provider,
                      )
                    : Center(child: Text('No chats')),
              );
            },
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ChatRepository(null).histchats(),
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
        Provider.of<ChatProvider>(context).getuserprofile(doc);
        final myid = FirebaseAuth.instance.currentUser?.uid;
        return ListView.builder(
          padding: const EdgeInsets.all(6),
          itemCount: doc.length,
          itemBuilder: (context, index) {
            final data = doc[index].data();
            final chatDomain = ChatDomain.fromJson(data);
            final otherids = chatDomain.participants?.length == 1
                ? myid
                : chatDomain.participants?.firstWhere(
                    (id) => id != myid,
                    orElse: () => myid!,
                  );

            final chatid = doc[index].id;

            return HistoryChatCard(
              chatDomain: chatDomain,
              chatid: chatid,
              isdesktop: isdesktop,
              otherid: otherids,
            );
          },
        );
      },
    );
  }
}
