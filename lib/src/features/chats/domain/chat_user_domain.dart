import 'package:chat_shop/src/features/chats/data/chat_data_source.dart';

class ChatUserDomain {
  final String id;
  final String name;
  final String email;
  final String profile;
  ChatUserDomain(this.id, this.name, this.email, this.profile);
}
