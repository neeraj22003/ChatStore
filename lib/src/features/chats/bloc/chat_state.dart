import 'package:chat_shop/src/features/chats/domain/chat_domain.dart';

abstract class ChatState {}

class ChatisInitial extends ChatState {}

class Chatloading extends ChatState {}

class Chatloaded extends ChatState {
  final List<ChatDomain> chat;
  final String id;
  Chatloaded(this.chat,this.id);
}

class Chaterror extends ChatState {
  final String? error;
  Chaterror(this.error);
}
