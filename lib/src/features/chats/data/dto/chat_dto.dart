import 'package:chat_shop/src/features/chats/domain/chat_domain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDto {
  final String senderid;
  final String reciverid;
  final String message;
  final DateTime? timestamp;

  ChatDto({
    required this.senderid,
    required this.reciverid,
    required this.message,
    this.timestamp,
  });

  Map<String, dynamic> todoc(bool issqflite) {
    return {
      'senderId': senderid,
      'receiverId': reciverid,
      'message': message,
      'timestamp': issqflite ? DateTime.now() : FieldValue.serverTimestamp(),
    };
  }

  factory ChatDto.fromdoc(Map<String, dynamic> data) {
    return ChatDto(
      senderid: data['senderId'],
      reciverid: data['receiverId'],
      message: data['message'],
      timestamp: data['timestamp'],
    );
  }
  ChatDomain toDomain() {
    return ChatDomain(
      senderid: senderid,
      reciverid: reciverid,
      message: message,
      timestamp: timestamp,
    );
  }
}
