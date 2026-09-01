import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String currentuserid;
  final String senderid;
  final DateTime timestamp;
  const ChatBubble({
    super.key,
    required this.message,
    required this.currentuserid,
    required this.senderid,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final screenhalfwidth = MediaQuery.of(context).size.width * 0.7;
    return Align(
      alignment: senderid==currentuserid ? Alignment.bottomRight : Alignment.bottomLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: screenhalfwidth, minWidth: 35),
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          elevation: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(style: TextStyle(fontSize: 12), message),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 8, right: 4),
                child: Text(
                  DateFormat("hh:mm").format(timestamp),
                  style: TextStyle(fontSize: 8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
