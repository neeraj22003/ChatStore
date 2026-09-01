import 'package:chat_shop/src/features/chat_history/domain/chat_history_repo.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_use_cases/Get_chat_history.dart';
class ChathistoryUseCases {
  final GetChatHistory getChatHistory;
  ChathistoryUseCases(ChatHistoryRepo repo)
    : getChatHistory = GetChatHistory(repo);
}
