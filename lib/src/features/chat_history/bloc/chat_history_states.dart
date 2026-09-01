import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_domain.dart';

abstract class ChatHistoryState {}

class ChatHistoryInitial extends ChatHistoryState {}

class ChatHistoryLoading extends ChatHistoryState {}

class ChatHistoryLoaded extends ChatHistoryState {
  final List<ChatHistoryDomain> history;
  final UserDomain currentUser;
  ChatHistoryLoaded(this.history,this.currentUser);
}

class ChatHistoryError extends ChatHistoryState {
  final String? error;
  ChatHistoryError(this.error);
}
