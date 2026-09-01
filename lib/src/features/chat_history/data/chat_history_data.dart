import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/chat_history/data/chat_history.dto.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_domain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHistoryData {
  final FirebaseFirestore store;
  ChatHistoryData(this.store);

  Result<Stream<List<ChatHistoryDomain>>> chatHistory(String currentUserId) {
    try {
      final result = store
          .collection('chats')
          .where('participants', arrayContains: currentUserId)
          .snapshots()
          .map((value) {
            final docs = value.docs
                .map((value) {
                  final data = ChatHistoryDto.fromdoc(value);

                  return data;
                })
                .where((dto) => dto.lastmessage.isNotEmpty)
                .map((dto) => dto.toDomain(currentUserId))
                .toList();
            print(docs.length);
            return docs;
          });

      return Result.onSuccess(result);
    } catch (e) {
      print(e.toString());
      return Result.onfailure(e.toString());
    }
  }
}
