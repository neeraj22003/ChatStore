import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/chats/data/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_experiments/features/chats/domain/chat_domain.dart';
import 'package:flutter_experiments/features/user/domain/user_domain.dart';

class ChatProvider extends ChangeNotifier {
  Map<String, UserDomain>? _users;
  Map<String, UserDomain>? get users => _users;
  ChatDomain? _chat;
  ChatDomain? get chat => _chat;
  final TextEditingController _msgController = TextEditingController();
  TextEditingController get msgcontroller => _msgController;

  bool _isDesktop = false;
  bool get isDesktop => _isDesktop;
  double? _firsttimewidth;
  double? get firstimewidth => _firsttimewidth;

  Future<void> getchatuser(ChatDomain? data, String chatid) async {
    if (data != null) {
      _chat = data;
    }
    _chat?.chatroomid = chatid;

    notifyListeners();
  }

  Future<void> getuserprofile(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> doc,
  ) async {
    final userprofile = await ChatRepository(null).preloadchatuser(doc);
    _users = userprofile;

    notifyListeners();
  }

  void desktopboolfunction(bool isdesktop) {
    _isDesktop = isdesktop;
    notifyListeners();
  }

  void sendmessage(
    String secondguy,
    String secondguyid,
    String getchatid,
    String lassmessage,
    String sender,
  ) async {
    await ChatRepository(
      null,
    ).sendmessage(secondguy, secondguyid, getchatid, lassmessage, sender);
    _msgController.clear();
  }
}
