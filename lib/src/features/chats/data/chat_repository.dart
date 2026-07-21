import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/features/chats/data/chat_data_source.dart';
import 'package:chat_shop/src/features/chats/domain/chat_domain.dart';
import 'package:chat_shop/src/features/chats/domain/chat_repo.dart';
import 'package:chat_shop/src/features/chats/domain/chat_user_domain.dart';
import 'package:chat_shop/src/features/user_dashboard/data/google_auth_service.dart';

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
   String chatUserid,
    String currentUserid,
    String message,
  ) async {
    final result = await data.sendMessage(chatUserid, currentUserid, message);
    if (result.isFailure) {
      return Result.onfailure(result.error);
    }
    return Result.onSuccess(result.data!);
  }
}
