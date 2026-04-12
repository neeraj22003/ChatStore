import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_experiments/core/layout/providers/navigation_provider.dart';
import 'package:flutter_experiments/core/services/images.dart';
import 'package:flutter_experiments/features/chats/ui/providers/privider.dart';

import 'package:flutter_experiments/features/chats/ui/widgets/chat_bubble.dart';
import 'package:flutter_experiments/features/chats/ui/widgets/sender_row.dart';

import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  final String? secondguyid;
  final String? secondguyname;
  final String? chatid;
  final bool isDesktop;
  final String? profileimage;
  const ChatPage({
    super.key,
    required this.secondguyid,
    required this.secondguyname,
    required this.chatid,
    required this.isDesktop,
    required this.profileimage,
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
            return ChatBubble(me: me, message: doc[index]['message']);
          },
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
        child: CircleAvatar(
          radius: 23,
          backgroundImage: profileimage != null
              ? CachedNetworkImageProvider(profileimage!)
              : AssetImage(ImageService.placeholder),
        ),
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
                    secondguyname ?? '',
                    style: TextStyle(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await Provider.of<ChatProvider>(
                    context,
                    listen: false,
                  ).deletechat(chatid!);
                  if (!context.mounted) return;
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },

                icon: const Icon(Icons.delete),
              ),
            ],

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
                image: AssetImage(ImageService.chatBg),
              ),
            ),
            child: Column(
              children: [
                Expanded(child: chatContainer()),
                SenderRow(
                  secondguyid: secondguyid,
                  secondguyname: secondguyname,
                  chatid: chatid,
                ),
                reactivebox(context),
              ],
            ),
          ),
        );
      },
    );
  }
}
