import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/core/utils/chat_utils.dart';
import 'package:chat_shop/src/features/chat_history/data/chat_history.dto.dart';
import 'package:chat_shop/src/features/chats/data/dto/chat_dto.dart';
import 'package:chat_shop/src/features/chats/domain/chat_domain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDataSource {
  final FirebaseFirestore store;
  ChatDataSource(this.store);

  Future<Result<bool>> sendMessage(
   ChatHistoryDto history
  ) async {
    try {
      final chatid = ChatUtils.genrateChatId(history.receiverid, history.senderid);
      final chats = store.collection('chats').doc(chatid);
      await chats.set(
        history.toDoc()
      , SetOptions(merge: true));

      await chats
          .collection('messages')
          .add(
            ChatDto(
              senderid:history.senderid,
              reciverid: history.receiverid,
              message:history.lastmessage,
            ).todoc(false),
          );
      return Result.onSuccess(true);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  Result<Stream<List<ChatDomain>>> loadchats(
    String chatUserId,
    String currentUserId,
  ) {
    try {
      final chatid = ChatUtils.genrateChatId(chatUserId, currentUserId);
     
      final result = store
          .collection('chats')
          .doc(chatid)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((shot) {
            return shot.docs.map((data) {
              return ChatDto.fromdoc(data.data()).toDomain();
            }).toList();
          });
      return Result.onSuccess(result);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }

  Future<Result<bool>> createChatDoc(
    String chatUserId,
    String currentUserId,
  ) async {
    try {
      final chatid = ChatUtils.genrateChatId(chatUserId, currentUserId);
      
      await store.collection('chats').doc(chatid).set({
        'participants': [chatUserId, currentUserId],
       
      }, SetOptions(merge: true));
      return Result.onSuccess(true);
    } catch (e) {
      return Result.onfailure(e.toString());
    }
  }
}
