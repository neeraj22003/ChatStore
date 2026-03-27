import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDomain {
  final String? sender;
  final String? receiver;
  final String? senderId;
  final String? receiverId;
  final String? lastmessage;
  final DateTime? timestamp;
  String? chatroomid;
  final List<String>? participants;
  ChatDomain({
    this.sender,
    this.receiver,
    this.senderId,
    this.receiverId,
    this.lastmessage,
    this.timestamp,
    this.chatroomid,
    this.participants,
  });

  factory ChatDomain.fromJson(Map<String, dynamic> data) {
    return ChatDomain(
      sender: data['sender'] ?? '',
      receiver: data['receiver'] ?? '',
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      lastmessage: data['lastmessage'] ?? '',
      timestamp: ((data['timestamp'] ?? Timestamp.now()).toDate()),
      chatroomid: data['chatroomid'] ?? '',
      participants: List<String>.from(data['participants'] ?? []),
    );
  }
}
