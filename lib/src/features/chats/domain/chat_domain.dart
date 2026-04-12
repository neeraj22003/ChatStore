import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDomain {
  final String? lastmessage;
  final DateTime? timestamp;
  String? chatroomid;
  String username;
  String userid;
  final List<String>? participants;
  ChatDomain({
    this.userid = '',
    this.username = '',
    this.lastmessage,
    this.timestamp,
    this.chatroomid,
    this.participants,
  });

  factory ChatDomain.fromJson(Map<String, dynamic> data) {
    return ChatDomain(
      lastmessage: data['lastMessage'] ?? '',
      timestamp: ((data['timestamp'] ?? Timestamp.now()).toDate()),
      chatroomid: data['chatroomid'] ?? '',
      participants: List<String>.from(data['participants'] ?? []),
    );
  }
}
