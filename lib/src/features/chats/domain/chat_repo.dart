import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_domain.dart';
import 'package:chat_shop/src/features/chats/domain/chat_domain.dart';

abstract class ChatRepo {
  Future<Result<bool>> sendMessage(
    ChatHistoryDomain history
  );
  Result<Stream<List<ChatDomain>>> loadchats(
    String chatUserid,
    String currentUserid,
  );
  Future<Result<bool>> createChatdoc(String chatUserId, String currentUserId);
}
