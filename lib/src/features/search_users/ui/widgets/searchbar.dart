import 'package:flutter/material.dart';

import 'package:chat_shop/src/features/search_users/ui/provider/search_user_provider.dart';

class UsersearchBar extends StatelessWidget {
  final SearchUserProvider provider;
  const UsersearchBar({super.key, required this.provider});

  Widget searchIcon() {
    return IconButton(
      onPressed: () {
        provider.onsubmit();
      },
      icon: const Icon(Icons.search),
    );
  }

  Widget searchfield() {
    return Flexible(
      child: TextField(
        controller: provider.controller,
        onSubmitted: (value) => provider.onsubmit(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          hintText: 'Search Users...',
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget erasebutton() {
    return IconButton(
      onPressed: () async {
        provider.clearfield();
      },
      icon: const Icon(Icons.close),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        clipBehavior: Clip.hardEdge,
        elevation: 0.8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(const Radius.circular(20)),
        ),
        color: color.surfaceContainerHighest,
        child: Row(children: [searchIcon(), searchfield(), erasebutton()]),
      ),
    );
  }
}
