import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/features/chats/data/dto/chat_dto.dart';
import 'package:chat_shop/src/features/chats/domain/chat_domain.dart';
import 'package:chat_shop/src/features/chats/domain/chat_user_domain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDataSource {
  final FirebaseFirestore store;
  ChatDataSource(this.store);

  String chatid(String chatUserid,String currentuserid) {
    List<String> ids = [currentuserid, chatUserid];
    ids.sort();
    return ids.join('_');
  }

  Future<Result<bool>> sendMessage(
    String chatUserid,
    String currentUserid,
    String message,
  ) async {
    try {
      await store
          .collection('messages')
          .doc(chatid(chatUserid, currentUserid))
          .collection('chats')
          .add(
            ChatDto(
              senderid: currentUserid,
              reciverid: chatUserid,
              message: message,
            ).todoc(false),
          );
      return Result.onSuccess(true);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  Result<Stream<List<ChatDomain>>> loadchats(
    String chatUserid,
    String currentUserid,
  ) {
    try {
      final result = store
          .collection('messages')
          .doc(chatid(chatUserid, currentUserid))
          .collection('chats')
          .snapshots()
          .map((shot) {
            final chat = shot.docs.map((data) {
              return ChatDto.fromdoc(data.data()).toDomain();
            }).toList();
            return chat;
          });
      return Result.onSuccess(result);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }
}
