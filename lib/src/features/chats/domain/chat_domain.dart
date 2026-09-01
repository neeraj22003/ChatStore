class ChatDomain {
  final String senderid;
  final String reciverid;
  final String message;
  final DateTime? timestamp;

  ChatDomain({
    required this.senderid,
    required this.reciverid,
    required this.message,
    this.timestamp,
  });
}
