import 'package:chat_shop/src/features/chat_history/domain/chat_history_domain.dart';

abstract class ChatEvent {}

class Sendmessage extends ChatEvent {
  ChatHistoryDomain history;
  Sendmessage(this.history);
}

class LoadMessage extends ChatEvent {
  final String chatuserid;
  LoadMessage(this.chatuserid);
}

class CreateChatdoc extends ChatEvent {
  final String chatuserId;
  CreateChatdoc(this.chatuserId);
}

class ResetChatstate extends ChatEvent{}
