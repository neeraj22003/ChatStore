import 'package:chat_shop/src/core/assets/images.dart';
import 'package:chat_shop/src/core/layout/utils/responsive.dart';
import 'package:chat_shop/src/features/chat_history/bloc/chat_history_bloc.dart';
import 'package:chat_shop/src/features/chat_history/bloc/chat_history_event.dart';
import 'package:chat_shop/src/features/chat_history/bloc/chat_history_states.dart';
import 'package:chat_shop/src/features/chat_history/notifiers/notifiers.dart';
import 'package:chat_shop/src/features/chat_history/ui/widgets/history_chat_card.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_bloc.dart';
import 'package:chat_shop/src/features/chats/bloc/chat_event.dart';
import 'package:chat_shop/src/features/chats/ui/screen/chat_page.dart';
import 'package:chat_shop/src/injecters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistorPage extends StatefulWidget {
  const HistorPage({super.key});

  @override
  State<HistorPage> createState() => _HistorPageState();
}

class _HistorPageState extends State<HistorPage> {
  final notfier = di<ChatNotifiers>();

  @override
  void initState() {
    super.initState();
    di<ChatHistoryBloc>().add(GetChatHistory());
  }

  Widget chatList() {
    return BlocBuilder<ChatHistoryBloc, ChatHistoryState>(
      builder: (context, state) {
        if (state is ChatHistoryInitial) {
          return Center(
            child: SizedBox(
              height: 350,
              child: Image.asset(ImageService.noChathistory),
            ),
          );
        } else if (state is ChatHistoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChatHistoryLoaded) {
          
          return ListView.builder(
          
            itemCount: state.history.length,
            itemBuilder: (context, index) {
              final history = state.history[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: HistoryChatCard(
                  name: history.chatUsername!,
                  selectedchatid: notfier.selectchatid,
                  message: history.lastmessage!,
                  profileimage: history.chatuserprofile,
                  chatid: history.chatId!,
                  onTap: () {
                    if (LayoutUtils.isBigScreen(context)) {
                      notfier.selectchatid.value = history.chatId!;
                      notfier.historyNotifier.value = history;
                      notfier.historyNotifier.value.currentUser =
                          state.currentUser;
                      di<ChatBloc>().add(CreateChatdoc(history.chatUserId!));
                    } else {
                      notfier.selectchatid.value = history.chatId!;
                      notfier.historyNotifier.value = history;
                      notfier.historyNotifier.value.currentUser =
                          state.currentUser;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            secondguyemail: history.chatUseremail,
                            secondguyid: history.chatUserId,
                            secondguyname: history.chatUsername,
                            currentuser: state.currentUser,
                            profileimage: history.chatuserprofile,
                          ),
                        ),
                      );
                    }
                  },
                  placeholder: ImageService.placeholder,
                ),
              );
            },
          );
        } else if (state is ChatHistoryError) {
          return Center(child: Text(state.error!));
        } else {
          return const Center(child: SizedBox.shrink());
        }
      },
    );
  }

  Widget chat() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7 - 160,
      child: ValueListenableBuilder(
        valueListenable: notfier.historyNotifier,
        builder: (context, value, child) {
          if (value.chatId == null || value.chatId!.isEmpty) {
            return Center(
              child: SizedBox(
                height: 350,
                child: Image.asset(ImageService.noChathistory),
              ),
            );
          } else {
            return ChatPage(
              secondguyemail: value.chatUseremail,
              secondguyid: value.chatUserId,
              secondguyname: value.chatUsername,
              currentuser: notfier.historyNotifier.value.currentUser!,
              profileimage: value.chatuserprofile,
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutUtils.isBigScreen(context)
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Expanded(child: chatList()),
              const VerticalDivider(width: 1, thickness: 1),
              chat(),
            ],
          )
        : chatList();
  }
}