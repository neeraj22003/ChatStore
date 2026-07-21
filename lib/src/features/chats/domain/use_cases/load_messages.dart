import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/features/chats/domain/chat_domain.dart';
import 'package:chat_shop/src/features/chats/domain/chat_repo.dart';
import 'package:chat_shop/src/features/chats/domain/chat_user_domain.dart';

class LoadMessages {
  final ChatRepo repo;
  LoadMessages(this.repo);
  Result<Stream<List<ChatDomain>>> call(
    String chatUserid,
    String currentUserid,
  ) {
    return repo.loadchats(chatUserid, currentUserid);
  }
}
