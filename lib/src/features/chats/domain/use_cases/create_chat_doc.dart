import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/chats/domain/chat_repo.dart';

class CreateChatDoc {
  final ChatRepo repo;
  CreateChatDoc(this.repo);
  Future<Result<bool>> call(String chatUserId, String currentUserId) async {
    return await repo.createChatdoc(chatUserId, currentUserId);
  }
}
