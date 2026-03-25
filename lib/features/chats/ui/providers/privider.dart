import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/chats/data/chat_repository.dart';
import 'package:flutter_experiments/features/user/domain/user_domain.dart';

class ChatProvider extends ChangeNotifier {
  UserDomain? _chatuser;
  UserDomain? get chatuser => _chatuser;
  final TextEditingController _msgController = TextEditingController();
  TextEditingController get msgcontroller => _msgController;

  bool _isDesktop = false;
  bool get isDesktop => _isDesktop;
  double? _firsttimewidth;
  double? get firstimewidth => _firsttimewidth;

  Future<void> getchatuser(
    Map<String, dynamic>? data,
    String? chatid,
    String id,
  ) async {
    if (data != null) {
      final fromjson = UserDomain.fromJson(data);
      _chatuser = fromjson;
    }

    _chatuser?.id = id;

    _chatuser?.chatroonmId = chatid ?? '';
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
