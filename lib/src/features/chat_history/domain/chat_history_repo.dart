import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/chat_history/domain/chat_history_domain.dart';

abstract class ChatHistoryRepo {
  Result<Stream<List<ChatHistoryDomain>>>chatHistory(String currentUserid);
  
}