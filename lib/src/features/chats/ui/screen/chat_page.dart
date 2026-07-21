import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_shop/src/core/assets/images.dart';
import 'package:chat_shop/src/core/widgets/circle_image.dart';
import 'package:chat_shop/src/features/cart/ui/widgets/divider.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_bloc.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_event.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_state.dart';
import 'package:chat_shop/src/features/chats/ui/widgets/chat_bubble.dart';
import 'package:chat_shop/src/features/chats/ui/widgets/sender_row.dart';
import 'package:chat_shop/src/injecters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  final String? secondguyid;
  final String? secondguyname;
  final String? secondguyemail;

  final String? profileimage;
  const ChatPage({
    super.key,
    required this.secondguyemail,
    required this.secondguyid,
    required this.secondguyname,

    required this.profileimage,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  Widget chatContainer() {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is Chatloading) {
          return const Center(
            child: SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        } else if (state is Chaterror) {
          return Center(child: Text(state.error!));
        } else if (state is ChatisInitial) {
          return Center(child: const Text('no chats yet'));
        } else if (state is Chatloaded) {
          return ListView.builder(
            itemCount: state.chat.length,
            itemBuilder: (context, index) {
              final chat = state.chat[index];
              ChatBubble(
                message: chat.message,
                currentuserid: state.currentUser.id,
                senderid: chat.senderid,
                timestamp: chat.timestamp!,
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget circleimage(ColorScheme color) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: CircleImage(
        image: widget.profileimage,
        placeholderImage: ImageService.placeholder,
        color: color.primary,
      ),
    );
  }

  Widget profileContainer(
    BuildContext context,
    ColorScheme color,
    bool isDesktop,
  ) {
    return Row(
      children: [
        
        circleimage(color),
        Flexible(
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 3),
            title: Text(
              widget.secondguyname ?? '',
              style: TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                widget.secondguyemail ?? '',
                style: TextStyle(fontSize: 11.5),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _chatBg(ColorScheme color) {
    return Container(
      decoration: BoxDecoration(
        color: color.surface,

        image: DecorationImage(
          opacity: 0.8,
          fit: BoxFit.none,
          repeat: ImageRepeat.repeat,
          colorFilter: ColorFilter.mode(color.surface, BlendMode.multiply),
          image: AssetImage(ImageService.chatBg),
        ),
      ),
      child: Column(
        children: [
          Expanded(child: chatContainer()),
          SenderRow(
            controller: _controller,
            onSend: () {
              di<ChatBloc>().add(
                Sendmessage(widget.secondguyid!, _controller.text),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final currentWidth = constraints.maxWidth;
        final isDesktopNow = currentWidth > 480;

        return Scaffold(
          appBar: AppBar(
            shadowColor: Colors.black,
            elevation: 6,
            leadingWidth: 230,
            leading: profileContainer(context, color, isDesktopNow),
            backgroundColor: color.surfaceContainer,
            actions: [IconButton(onPressed: (){}, icon:Icon(Icons.more_vert))],
          ),

          body: _chatBg(color),
        );
      },
    );
  }
}
