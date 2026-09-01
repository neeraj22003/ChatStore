class ChatUtils {
  static String genrateChatId(String chatUserId, String currentUserId) {
    final List<String> ids = [chatUserId, currentUserId];
    ids.sort();
    return ids.join('_');
  }
}
