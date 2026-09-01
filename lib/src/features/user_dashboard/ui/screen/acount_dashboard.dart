import 'package:chat_shop/src/core/all_state_reseter/reseter.dart';
import 'package:chat_shop/src/core/assets/images.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/features/auth/cubit/auth_cubit.dart';
import 'package:chat_shop/src/features/user_dashboard/cubit/user_cubit.dart';

import 'package:chat_shop/src/features/user_dashboard/cubit/user_state.dart';

import 'package:chat_shop/src/core/widgets/outlined_button.dart';
import 'package:chat_shop/src/injecters.dart';
import 'package:flutter/material.dart';

import 'package:chat_shop/src/features/user_dashboard/ui/widget/google_link_widget.dart';

import 'package:chat_shop/src/features/user_dashboard/ui/widget/profile_container.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AccountDashboard extends StatefulWidget {
  const AccountDashboard({super.key});

  @override
  State<AccountDashboard> createState() => _AccountDashboardState();
}

class _AccountDashboardState extends State<AccountDashboard> {
  @override
  void initState() {
    super.initState();
    di<UserDashboardCubit>().getUser();
  }

  Widget lougoutbutton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await di<AuthCubit>().logout();
         di<Reseter>().call();
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: const Text('Log Out'),
    );
  }

  Widget _profilecontainer(UserDomain user) {
    return ProfileContainer(
      profileImage: user.profileimage,
      placeholderImage: ImageService.placeholder,
      profleTitle: user.name,
      profilesubtitle: user.email,
    );
  }

  Widget _googlelinkWidget(bool isLinked, BuildContext context) {
    return GoogleLinkWidget(
      leadingImage: ImageService.google,
      title: isLinked ? 'Google Account Linked' : 'Connect to Google Account',
      subtitle: isLinked
          ? 'Linked successfully — no further action needed'
          : 'Sync your account with Google',
      trailing: isLinked
          ? Text("Linked", style: TextStyle(fontSize: 12, color: Colors.green))
          : Customoutlinebutton(
              onPressed: () async {},
              width: 50,
              text: 'Link',
              color: const Color(0xFFB71C1C),
            ),

      onTap: () {
        di<UserDashboardCubit>().linkWithGoogle();
      },
    );
  }

  Widget _unlinkbutton(bool islinked, BuildContext context) {
    return !islinked
        ? const SizedBox.shrink()
        : TextButton(
            onPressed: () async {
              di<UserDashboardCubit>().unlink();
            },
            child: const Text('Unlink'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDashboardCubit, UserDashBoardState>(
      builder: (context, state) {
        if (state is UserDashBoardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserDashBoardError) {
          return Center(
            child: AlertDialog(
              title: Text('Linking Error'),
              content: Text(
                'Something went wrong while linking ,Please retry.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    di<UserDashboardCubit>().retry();
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        } else if (state is UserDashBoardLoaded) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _profilecontainer(state.user),

                  _googlelinkWidget(state.islinked, context),

                  Divider(thickness: 1.5),

                  const SizedBox(height: 30),

                  lougoutbutton(context),
                  const SizedBox(height: 30),
                  _unlinkbutton(state.islinked, context),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
