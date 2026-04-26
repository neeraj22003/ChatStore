import 'dart:math';

import 'package:flutter/material.dart';
import 'package:chat_shop/src/core/services/images.dart';
import 'package:chat_shop/src/features/chats/ui/providers/privider.dart';
import 'package:chat_shop/src/features/search_users/data/search_user_repository.dart';
import 'package:chat_shop/src/features/search_users/ui/widgets/user_card.dart';

class Userbuilder extends StatelessWidget {
  final String query;
  final ChatProvider chatProvider;

  const Userbuilder({
    super.key,
    required this.query,
    required this.chatProvider,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    if (query.isEmpty) {
      return Center(
        child: Center(
          child: SizedBox(
            height: 200,
            child: Image.asset(
              theme.brightness == Brightness.dark
                  ? ImageService.searchUserdark
                  : ImageService.searchUser,
            ),
          ),
        ),
      );
    }
    return FutureBuilder(
      future: SearchUserRepository().searchUserFuture(query.toLowerCase()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No User Found'));
        }
        final users = snapshot.data!;
        return LayoutBuilder(
          builder: (context, constrainst) {
            final count = max(1, constrainst.maxWidth ~/ 200);
            final isdesktop = constrainst.maxWidth > 480;
            final cardwidth = (constrainst.maxWidth - 16) / count;
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: users.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: count,
                mainAxisExtent: 80,
              ),
              itemBuilder: (context, index) => UserCard(
                user: users.docs[index],
                isdesktop: isdesktop,
                width: cardwidth,
                chatProvider: chatProvider,
              ),
            );
          },
        );
      },
    );
  }
}
