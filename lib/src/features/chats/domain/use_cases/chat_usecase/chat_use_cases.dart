import 'package:chat_shop/src/features/chats/domain/chat_repo.dart';
import 'package:chat_shop/src/features/chats/domain/use_cases/load_messages.dart';
import 'package:chat_shop/src/features/chats/domain/use_cases/send_message.dart';

class ChatUseCases {
  final SendMessage sendMessage;
  final LoadMessages loadMessages;
  ChatUseCases(ChatRepo repo)
    : sendMessage = SendMessage(repo),
      loadMessages = LoadMessages(repo);
}
