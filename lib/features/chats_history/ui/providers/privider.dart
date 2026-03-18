import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;
  final TextEditingController _msgController = TextEditingController();
  TextEditingController get msgcontroller => _msgController;
  String? _id;
  String? get id => _id;
  String? _chatid;
  String? get chatid => _chatid;
  String? _title;
  String? get title => _title;
  bool _isDesktop = false;
  bool get isDesktop => _isDesktop;
  double? _firsttimewidth;
  double? get firstimewidth => _firsttimewidth;

  void onsumbmitted() {
    notifyListeners();
  }

  void clearfiled() {
    _controller.clear();
    notifyListeners();
  }

  String getchatid(String secondguyid) {
    final curremtid = FirebaseAuth.instance.currentUser!.uid;
    List<String> ids = [curremtid, secondguyid];
    ids.sort();
    return ids.join('_');
  }

  void addChatidTilereciverid(String id, String title, String? chatid) {
    _chatid = chatid;
    _id = id;
    _title = title;
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
  ) async {
    final curremtid = FirebaseAuth.instance.currentUser!.uid;
    final sender = await getname();

    await FirebaseFirestore.instance.collection('messages').doc(getchatid).set({
      'participants': [curremtid, secondguyid],
      'sender': sender,
      'receiver': secondguy,
      'senderId': curremtid,
      'receiverId': secondguyid,
      'lastMessage': _msgController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    await FirebaseFirestore.instance
        .collection('messages')
        .doc(getchatid)
        .collection('chats')
        .add({
          'senderId': curremtid,
          'receiverId': secondguyid,
          'message': _msgController.text.trim(),
          'timestamp': FieldValue.serverTimestamp(),
        });
    _msgController.clear();
  }

  Future<String> getname() async {
    String name = '';
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    if (doc.exists) {
      name = doc.data()?['name'];
    }
    return name;
  }
}
