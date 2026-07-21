import 'package:chat_shop/src/features/chats/domain/chat_user_domain.dart';

abstract class ChatEvent {}

class Sendmessage extends ChatEvent {
  final String chatUserid;

  final String message;
  Sendmessage(this.chatUserid, this.message);
}

class LoadMessage extends ChatEvent {
  final String chatuserid;
  LoadMessage(this.chatuserid);
}
