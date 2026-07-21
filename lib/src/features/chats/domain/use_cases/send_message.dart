import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';

import 'package:chat_shop/src/features/chats/domain/chat_repo.dart';
import 'package:chat_shop/src/features/chats/domain/chat_user_domain.dart';

class SendMessage {
  final ChatRepo repo;
  SendMessage(this.repo);
  Future<Result<bool>> call(
    String chatUserid,
    String currentUserid,
    String message,
  ) async {
    return await repo.sendMessage(chatUserid, currentUserid, message);
  }
}
