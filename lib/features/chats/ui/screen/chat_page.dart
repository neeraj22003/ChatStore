import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_experiments/core/layout/providers/navigation_provider.dart';
import 'package:flutter_experiments/features/chats/ui/providers/privider.dart';
import 'package:flutter_experiments/features/user/ui/provider/provider.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  final String secondguyid;
  final String secondguyname;
  final String chatid;
  final bool isDesktop;

  const ChatPage({
    super.key,
    required this.secondguyid,
    required this.secondguyname,
    required this.chatid,
    required this.isDesktop,
  });

  Widget reactivebox(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        // If keyboard is open, height becomes 0
        height: MediaQuery.of(context).viewInsets.bottom > 0 ? 0 : 50,
        child: const SizedBox.shrink(),
      );
    }
    return const SizedBox(height: 0);
  }

  Widget chatbubble(bool me, String message, context) {
    final color = Theme.of(context).colorScheme;
    return Align(
      alignment: me ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        child: Material(
          elevation: 4,
          color: me ? Color(0xFFD1E4FF) : color.surfaceBright,
          borderRadius: BorderRadius.only(
            topLeft: me ? const Radius.circular(8) : Radius.zero,
            topRight: me ? Radius.zero : const Radius.circular(8),
            bottomLeft: const Radius.circular(8),
            bottomRight: const Radius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(color: me ? Color(0xFF001D36) : null),
            ),
          ),
        ),
      ),
    );
  }

  Widget chatContainer() {
    final chatcollecteionStream = FirebaseFirestore.instance
        .collection('messages')
        .doc(chatid)
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .snapshots();
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: chatcollecteionStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: SizedBox());
        var doc = snapshot.data!.docs;
        return ListView.builder(
          padding: EdgeInsets.all(0),
          reverse: true,
          itemCount: doc.length,
          itemBuilder: (context, index) {
            bool me = doc[index]['senderId'] == currentUserId;
            return chatbubble(me, doc[index]['message'], context);
          },
        );
      },
    );
  }

  Widget sender(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Consumer2<ChatProvider, Userprovider>(
      builder: (context, provider, currentuser, child) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Material(
                  elevation: 6,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: color.surfaceBright,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      controller: provider.msgcontroller,
                      onSubmitted: (value) => provider.sendmessage(
                        secondguyname,
                        secondguyid,
                        chatid,
                        provider.msgcontroller.text,
                        currentuser.userDomain?.name ?? '',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Message',
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => provider.sendmessage(
                  secondguyname,
                  secondguyid,
                  chatid,
                  provider.msgcontroller.text,
                  currentuser.userDomain?.name ?? '',
                ),

                icon: Icon(Icons.send_rounded, color: color.primary),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget circleimage(ColorScheme color) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        backgroundColor: color.primary,
        radius: 27,
        child: CircleAvatar(radius: 23, child: Icon(Icons.person, size: 40)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final navi = context.watch<NavigationProvider>();

    final color = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final currentWidth = constraints.maxWidth;
        final isDesktopNow = currentWidth > 480;

        if (!isDesktop && isDesktopNow) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (Navigator.canPop(context)) {
              navi.ontapbottom(2);
              Navigator.pop(context);
            }
          });
        }

        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            leadingWidth: 250,
            leading: Row(
              children: [
                isDesktop
                    ? const SizedBox.shrink()
                    : IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                circleimage(color),
                Flexible(
                  child: Text(
                    secondguyname,
                    style: TextStyle(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            backgroundColor: color.surfaceContainer,
          ),

          body: Container(
            decoration: BoxDecoration(
              color: color.surface,

              image: DecorationImage(
                opacity: 0.8,
                fit: BoxFit.none,
                repeat: ImageRepeat.repeat,
                colorFilter: ColorFilter.mode(
                  color.surface,
                  BlendMode.multiply,
                ),
                image: AssetImage('assets/bg.jpg'),
              ),
            ),
            child: Column(
              children: [
                Expanded(child: chatContainer()),
                sender(context),
                reactivebox(context),
              ],
            ),
          ),
        );
      },
    );
  }
}
