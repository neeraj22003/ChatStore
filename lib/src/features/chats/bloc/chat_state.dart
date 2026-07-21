import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/features/chats/domain/chat_domain.dart';

abstract class ChatState {}

class ChatisInitial extends ChatState {}

class Chatloading extends ChatState {}

class Chatloaded extends ChatState {
  final List<ChatDomain> chat;
  final UserDomain currentUser;
  Chatloaded(this.chat,this.currentUser);
}

class Chaterror extends ChatState {
  final String? error;
  Chaterror(this.error);
}
