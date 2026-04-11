import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/chats/ui/providers/privider.dart';

import 'package:flutter_experiments/features/user/ui/provider/provider.dart';
import 'package:provider/provider.dart';

class SenderRow extends StatelessWidget {
  final String? secondguyid;
  final String? secondguyname;
  final String? chatid;
  const SenderRow({
    super.key,
    required this.secondguyid,
    required this.secondguyname,
    required this.chatid,
  });

  Widget sendbutton(
    ColorScheme color,
    ChatProvider provider,
    Userprovider currentuser,
  ) {
    bool isdark = color.brightness == Brightness.dark;
    return IconButton(
      onPressed: () => provider.msgcontroller.text.trim().isEmpty
          ? () {}
          : provider.sendmessage(
              secondguyname ?? '',
              secondguyid ?? '',
              chatid ?? '',
              provider.msgcontroller.text,
              currentuser.userDomain?.name ?? '',
            ),

      icon: Icon(
        shadows: [
          ?isdark && provider.msgcontroller.text.isNotEmpty
              ? BoxShadow(
                  color: provider.msgcontroller.text.trim().isEmpty
                      ? const Color.fromARGB(255, 253, 255, 255)
                      : const Color.fromARGB(255, 66, 255, 255),
                  spreadRadius: 10,
                  blurRadius: 10,
                )
              : null,
        ],
        Icons.send_rounded,
        size: 30,
        color: provider.msgcontroller.text.trim().isEmpty
            ? color.secondary
            : isdark
            ? Colors.white
            : Color(0xFF4169E1),
      ),
    );
  }

  Widget textfield(
    ColorScheme color,
    ChatProvider provider,
    Userprovider currentuser,
  ) {
    return Material(
      elevation: 6,
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      color: color.surfaceBright,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: TextField(
          controller: provider.msgcontroller,
          onSubmitted: (value) => provider.msgcontroller.text.trim().isEmpty
              ? () {}
              : provider.sendmessage(
                  secondguyname ?? '',
                  secondguyid ?? '',
                  chatid ?? '',
                  provider.msgcontroller.text,
                  currentuser.userDomain?.name ?? '',
                ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Message',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Consumer2<ChatProvider, Userprovider>(
      builder: (context, provider, currentuser, child) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(child: textfield(color, provider, currentuser)),
              sendbutton(color, provider, currentuser),
            ],
          ),
        );
      },
    );
  }
}
