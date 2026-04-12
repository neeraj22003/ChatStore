import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/chats/ui/providers/privider.dart';

import 'package:flutter_experiments/features/search_users/ui/provider/search_user_provider.dart';
import 'package:flutter_experiments/features/search_users/ui/widgets/searchbar.dart';
import 'package:flutter_experiments/features/search_users/ui/widgets/userbuilder.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<SearchUserProvider, ChatProvider>(
      builder: (context, provider, chat, child) => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: UsersearchBar(provider: provider)),
          SliverFillRemaining(
            child: Userbuilder(
              query: provider.controller.text.trim(),
              chatProvider: chat,
            ),
          ),
        ],
      ),
    );
  }
}
