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
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Consumer2<ChatProvider, Userprovider>(
      builder: (context, provider, currentuser, child) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Material(
                  elevation: 6,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: color.surfaceBright,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      controller: provider.msgcontroller,
                      onSubmitted: (value) => provider.sendmessage(
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
                ),
              ),
              IconButton(
                onPressed: () => provider.sendmessage(
                  secondguyname ?? '',
                  secondguyid ?? '',
                  chatid ?? '',
                  provider.msgcontroller.text,
                  currentuser.userDomain?.name ?? '',
                ),

                icon: Icon(Icons.send_rounded, color: color.primary),
              ),
            ],
          ),
        );
      },
    );
  }
}
