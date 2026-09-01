import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/chat_history/data/chat_history_data.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_domain.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_repo.dart';

class ChatHistoryRepoImpl implements ChatHistoryRepo {
  final ChatHistoryData data;
  ChatHistoryRepoImpl(this.data);
  @override
  Result<Stream<List<ChatHistoryDomain>>> chatHistory(String currentUserId) {
    final result = data.chatHistory(currentUserId);
    if (result.isFailure) {
      return Result.onfailure(result.error);
    }
    return Result.onSuccess(result.data!);
  }

 
}
