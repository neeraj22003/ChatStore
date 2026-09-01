import 'package:chat_shop/src/core/assets/images.dart';
import 'package:chat_shop/src/core/layout/utils/responsive.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/core/widgets/circle_image.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_domain.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_bloc.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_event.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_state.dart';
import 'package:chat_shop/src/features/chats/ui/screen/chat_view.dart';
import 'package:chat_shop/src/features/chats/ui/widgets/sender_row.dart';
import 'package:chat_shop/src/injecters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  final String? secondguyid;
  final String? secondguyname;
  final String? secondguyemail;
  final UserDomain currentuser;
  final String? profileimage;
  const ChatPage({
    super.key,
    required this.secondguyemail,
    required this.secondguyid,
    required this.secondguyname,
    required this.currentuser,
    required this.profileimage,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    di<ChatBloc>().add(CreateChatdoc(widget.secondguyid!));
  }

  Widget chatContainer() {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is Chatloading) {
          return const Center(
            child: SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          );
        } else if (state is Chaterror) {
          return Center(child: Text(state.error!));
        } else if (state is ChatisInitial) {
          return Center(child: const Text('no chats yet'));
        } else if (state is Chatloaded) {
          return ChatSview(
            chats: state.chat,
            currentUserid: widget.currentuser.id,
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
        isDesktop
            ? const SizedBox.shrink()
            : IconButton(
                highlightColor: const Color.fromARGB(255, 216, 214, 214),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(color: Colors.white, Icons.arrow_back),
              ),
        circleimage(color),
        Expanded(
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 3),
            title: Text(
              widget.secondguyname ?? '',

              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 3, right: 20),
              child: Text(
                widget.secondguyemail ?? '',
                style: TextStyle(fontSize: 11.5, color: Colors.white),
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
                Sendmessage(
                  ChatHistoryDomain(
                    receiverid: widget.secondguyid!,
                    lastmessage: _controller.text.trim(),
                    receiverName: widget.secondguyname!,
                    receiverEmail: widget.secondguyemail!,
                    receiverProfile: widget.profileimage!,
                    senderid: widget.currentuser.id,
                    senderName: widget.currentuser.name,
                    senderEmail: widget.currentuser.email,
                    senderProfile: widget.currentuser.profileimage,
                  ),
                ),
              );
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MediaQuery.of(context).size.width > 485) {
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 6,
        leadingWidth: 300,
        leading: profileContainer(
          context,
          color,
          LayoutUtils.isBigScreen(context),
        ),
        backgroundColor: const Color.fromARGB(255, 10, 33, 108),
        actions: [
          IconButton(
            highlightColor: const Color.fromARGB(255, 222, 222, 222),
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),

      body: _chatBg(color),
    );
  }
}
