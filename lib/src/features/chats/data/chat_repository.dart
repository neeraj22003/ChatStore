import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_domain.dart';
import 'package:chat_shop/src/features/chats/data/chat_data_source.dart';
import 'package:chat_shop/src/features/chats/domain/chat_domain.dart';
import 'package:chat_shop/src/features/chats/domain/chat_repo.dart';

class ChatRepoImpl extends ChatRepo {
  final ChatDataSource data;
  ChatRepoImpl(this.data);

  @override
  Result<Stream<List<ChatDomain>>> loadchats(
    String chatUserid,
    String currentUserid,
  ) {
    final result = data.loadchats(chatUserid, currentUserid);
    if (result.isFailure) {
      return Result.onfailure(result.error);
    }
    return Result.onSuccess(result.data!);
  }

  @override
  Future<Result<bool>> sendMessage(
    ChatHistoryDomain history
  ) async {
    final result = await data.sendMessage(history.toDto());
    if (result.isFailure) {
      return Result.onfailure(result.error);
    }
    return Result.onSuccess(result.data!);
  }

  @override
  Future<Result<bool>> createChatdoc(
    String chatUserId,
    String currentUserId,
  ) async {
    final result = await data.createChatDoc(chatUserId, currentUserId);
    if (result.isFailure) {
      return Result.onfailure(result.error);
    }
    return Result.onSuccess(result.data!);
  }
}
