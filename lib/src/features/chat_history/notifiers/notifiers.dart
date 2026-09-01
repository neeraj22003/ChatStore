import 'package:chat_shop/src/features/chat_history/domain/chat_history_domain.dart';
import 'package:flutter/foundation.dart';

class ChatNotifiers{
  final ValueNotifier<String> selectchatid = ValueNotifier('');
  final ValueNotifier<ChatHistoryDomain> historyNotifier = ValueNotifier(
    ChatHistoryDomain(),
  );
  
}