import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/features/chats/domain/chat_domain.dart';
import 'package:chat_shop/src/features/chats/domain/chat_user_domain.dart';

abstract class ChatRepo {
  Future<Result<bool>> sendMessage(
    String chatUserid,
    String currentUserid,
    String message,
  );
  Result<Stream<List<ChatDomain>>> loadchats(
    String chatUserid,
    String currentUserid,
  );
}
