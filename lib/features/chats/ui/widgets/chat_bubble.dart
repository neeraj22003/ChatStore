import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool me;
  final String message;
  const ChatBubble({super.key, required this.me, required this.message});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Align(
      alignment: me ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        child: Card(
          color: me ? Color(0xFFD1E4FF) : color.surfaceBright,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: me ? const Radius.circular(8) : Radius.zero,
              topRight: me ? Radius.zero : const Radius.circular(8),
              bottomLeft: const Radius.circular(8),
              bottomRight: const Radius.circular(8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(color: me ? Color(0xFF001D36) : null),
            ),
          ),
        ),
      ),
    );
  }
}
