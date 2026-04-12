import 'package:flutter/material.dart';

import 'package:flutter_experiments/core/layout/providers/navigation_provider.dart';

import 'package:flutter_experiments/features/user/ui/provider/provider.dart';
import 'package:flutter_experiments/features/user/ui/widget/google_link_widget.dart';

import 'package:flutter_experiments/features/user/ui/widget/profile_container.dart';
import 'package:flutter_experiments/features/user/ui/widget/unlink_button.dart';
import 'package:provider/provider.dart';

class AccountDashboard extends StatelessWidget {
  const AccountDashboard({super.key});

  Widget lougoutbutton(Userprovider user, BuildContext context) {
    return TextButton(
      onPressed: () {
        user.logout();
        Navigator.pop(context);
      },
      child: const Text('Log Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<Userprovider, NavigationProvider>(
      builder: (context, user, navi, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => navi.closedrwaer(false),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileContainer(user: user.userDomain),
                Divider(thickness: 1.5),
                GoogleLinkWidget(provider: user),
                const SizedBox(height: 30),
                lougoutbutton(user, context),
                const SizedBox(height: 30),
                UnlinkButton(user: user),
              ],
            ),
          ),
        );
      },
    );
  }
}
