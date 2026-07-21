



/*class AdaptiveHistoryPage extends StatelessWidget {
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
                        secondguyid: chat.userid,
                        secondguyname: provider.users?[chat.userid]?.name,
                        chatid: chat.chatroomid,
                        isDesktop: isdesktop,
                        profileimage:
                            provider.users?[chat.userid]?.profileimage,
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
      stream: ChatRepository(FirebaseAuth.instance.currentUser).histchats(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {}
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Messages Yet'));
        }
        final doc = snapshot.data!.docs;
        Provider.of<ChatProvider>(context, listen: true).getuserprofile(doc);

        return ListView.builder(
          padding: const EdgeInsets.all(6),
          itemCount: doc.length,
          itemBuilder: (context, index) {
            final data = doc[index].data();
            final chatDomain = ChatDomain.fromJson(data);
            final myid = FirebaseAuth.instance.currentUser?.uid;
            final userid = chatDomain.participants?.firstWhere(
              (id) => id != myid,
              orElse: () => '',
            );
            chatDomain.userid = userid ?? '';
            final chatid = doc[index].id;

            return HistoryChatCard(
              chatDomain: chatDomain,
              chatid: chatid,
              isdesktop: isdesktop,
            );
          },
        );
      },
    );
  }
}
*/