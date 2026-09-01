import 'package:chat_shop/src/features/chat_history/domain/chat_history_domain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHistoryDto {
  final String senderid;
  final String senderName;
  final String receiverid;
  final String receiverName;
  final String senderProfile;
  final String receiverProfile;
  final String lastmessage;
  final String senderEmail;
  final String receiverEmail;
  final String chatid;
  ChatHistoryDto({
    required this.chatid,
    required this.senderid,
    required this.senderName,
    required this.receiverid,
    required this.receiverName,
    required this.senderProfile,
    required this.receiverProfile,
    required this.lastmessage,
    required this.senderEmail,
    required this.receiverEmail,
  });

  factory ChatHistoryDto.fromdoc(
    QueryDocumentSnapshot<Map<String, dynamic>> value,
  ) {
    final data = value.data();
    return ChatHistoryDto(
      chatid: value.id,
      senderid: data['senderid'] ?? '',
      senderName: data['senderName'] ?? '',
      receiverid: data['receiverid'] ?? '',
      receiverName: data['receiverName'] ?? '',
      senderProfile: data['senderProfile'] ?? '',
      receiverProfile: data['receiverProfile'] ?? '',
      lastmessage: data['lastmessage'] ?? '',
      senderEmail: data['senderEmail'] ?? '',
      receiverEmail: data['receiverEmail'] ?? '',
    );
  }

  Map<String, dynamic> toDoc() {
    return {
      'senderid': senderid,
      'participants': [receiverid, senderid],
      'senderName': senderName,
      'receiverid': receiverid,
      'receiverName': receiverName,
      'senderProfile': senderProfile,
      'receiverProfile': receiverProfile,
      'lastmessage': lastmessage,
      "senderEmail": senderEmail,
      'receiverEmail': receiverEmail,
    };
  }

  ChatHistoryDomain toDomain(String currentuserid) {
    final bool senderIsme = currentuserid == senderid;
    final chatUsername = senderIsme ? receiverName : senderName;
    final chatuserprofile = senderIsme ? receiverProfile : senderProfile;
    final chatUserId = senderIsme ? receiverid : senderid;
    final chatUseremail = senderIsme ? receiverEmail : senderEmail;
    return ChatHistoryDomain(
      lastmessage: lastmessage,
      chatUsername: chatUsername,
      chatuserprofile: chatuserprofile,
      chatUserId: chatUserId,
      chatUseremail: chatUseremail,
      chatId: chatid
    );
  }
}
