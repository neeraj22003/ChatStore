import 'package:chat_shop/src/features/chats/bloc/chat_bloc.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_state.dart';
import 'package:chat_shop/src/features/chats/domain/chat_domain.dart';
import 'package:chat_shop/src/features/chats/ui/widgets/chat_bubble.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatSview extends StatefulWidget {
  final List<ChatDomain> chats;
  final String currentUserid;
  @override
  State<StatefulWidget> createState() => _StateChatState();
  const ChatSview({
    super.key,
    required this.chats,
    required this.currentUserid,
  });
}

class _StateChatState extends State<ChatSview> {
  late List<ChatDomain> _chats;
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    super.initState();
    _chats = widget.chats;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listenWhen: (previous, current) =>
          previous is Chatloaded &&
          current is Chatloaded &&
          current.chat.length > previous.chat.length,
      listener: (context, state) {
        final message = (state as Chatloaded).chat.first;
        _chats.insert(0, message);
        _key.currentState?.insertItem(0);
      },
      child: AnimatedList(
        reverse: true,
        initialItemCount: _chats.length,
        key: _key,
        itemBuilder: (context, index, animation) {
          final newmessage = _chats[index];
          return SizeTransition(
            sizeFactor: animation,
            child: Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,bottom: 4),
              child: ChatBubble(
                message: newmessage.message,
                currentuserid: widget.currentUserid,
                senderid: newmessage.senderid,
                timestamp: newmessage.timestamp!,
              ),
            ),
          );
        },
      ),
    );
  }
}
