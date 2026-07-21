import 'package:chat_shop/src/core/assets/images.dart';
import 'package:chat_shop/src/core/widgets/itembuilder.dart';
import 'package:chat_shop/src/core/widgets/searchbar.dart';
import 'package:chat_shop/src/features/chats/ui/screen/chat_page.dart';
import 'package:chat_shop/src/features/search_users/bloc/search_user_block.dart';
import 'package:chat_shop/src/features/search_users/bloc/search_user_event.dart';
import 'package:chat_shop/src/features/search_users/bloc/search_user_state.dart';

import 'package:chat_shop/src/features/search_users/ui/widgets/search_user_card.dart';
import 'package:chat_shop/src/injecters.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final TextEditingController _controller = TextEditingController();
  Widget _userbuilder(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocBuilder<SearchUserBloc, SearchUserState>(
      builder: (context, state) {
        if (state is SearchUserInitial) {
          return Center(
            child: SizedBox(
              height: 200,
              child: Image.asset(
                theme.brightness == Brightness.dark
                    ? ImageService.searchUserdark
                    : ImageService.searchUser,
              ),
            ),
          );
        }
        if (state is SearchUserLoading) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (state is SearchUserLoaded) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Itembuilder(
              items: state.users,
              mincount: 1,
              truncatedevidecountvalue: 250,
              mainaxisextent: 75,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, user) {
                return CustomUsercard(
                  title: user.name,
                  placeholder: ImageService.placeholder,
                  subtitle: user.email,
                  userImage: user.profileimage,
                  trailing: state.currentuser.id == user.id
                      ? null
                      : const Icon(Icons.chat),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          secondguyid: user.id,
                          secondguyname: user.name,
                          profileimage: user.profileimage,
                          secondguyemail: user.email,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        } else {
          return Center(child: Text('no user'));
        }
      },
    );
  }

  Widget _searchbar() {
    return CustomSearchbar(
      onSearch: () {
        di<SearchUserBloc>().add(SearchUser(_controller.text.trim()));
      },
      textFieldcontroller: _controller,
      hintText: 'Search User',
      onremove: () {
        di<SearchUserBloc>().add(ClearField(_controller));
      },

      iscategory: ValueNotifier(''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _searchbar()),
        SliverToBoxAdapter(child: _userbuilder(context)),
      ],
    );
  }
}
