import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/features/chat_history/data/chat_history.dto.dart';

class ChatHistoryDomain {
  final String? chatId;
  final String? senderid;
  final String? senderName;
  final String? receiverid;
  final String? receiverName;
  final String? senderProfile;
  final String? receiverProfile;
  final String? lastmessage;
  final String? senderEmail;
  final String? receiverEmail;
  final String? chatUsername;
  final String? chatuserprofile;
  final String? chatUserId;
  final String? chatUseremail;
   UserDomain? currentUser;
  ChatHistoryDomain({
    this.chatId,
    this.senderid,
    this.currentUser,
    this.senderName,
    this.receiverid,
    this.receiverName,
    this.senderProfile,
    this.receiverProfile,
    this.lastmessage,
    this.senderEmail,
    this.receiverEmail,
    this.chatUsername,
    this.chatuserprofile,
    this.chatUserId,
    this.chatUseremail,
  });

  ChatHistoryDto toDto() {
    return ChatHistoryDto(
      chatid: '',
      senderid: senderid ?? '',
      senderName: senderName ?? '',
      receiverid: receiverid ?? '',
      receiverName: receiverName ?? '',
      senderProfile: senderProfile ?? '',
      receiverProfile: receiverProfile ?? '',
      lastmessage: lastmessage ?? '',
      senderEmail: senderEmail ?? '',
      receiverEmail: receiverEmail ?? '',
    );
  }
}
