import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_domain.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_repo.dart';

class GetChatHistory {
  final ChatHistoryRepo repo;
  GetChatHistory(this.repo);
  Result<Stream<List<ChatHistoryDomain>>> call(String currentUserId) {
    return repo.chatHistory(currentUserId);
  }
}
