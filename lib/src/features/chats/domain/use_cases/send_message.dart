import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_domain.dart';

import 'package:chat_shop/src/features/chats/domain/chat_repo.dart';

class SendMessage {
  final ChatRepo repo;
  SendMessage(this.repo);
  Future<Result<bool>> call(
  ChatHistoryDomain history
  ) async {
    return await repo.sendMessage(history);
  }
}
