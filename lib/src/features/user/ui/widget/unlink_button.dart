import 'package:flutter/material.dart';
import 'package:chat_shop/src/features/user/ui/provider/provider.dart';

class UnlinkButton extends StatelessWidget {
  final Userprovider user;
  const UnlinkButton({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return user.loading
        ? const CircularProgressIndicator()
        : TextButton(
            onPressed: () async {
              await user.unlink();
            },
            child: const Text('Unlink'),
          );
  }
}
