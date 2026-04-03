import 'package:flutter/material.dart';

import 'package:flutter_experiments/core/layout/providers/navigation_provider.dart';
import 'package:flutter_experiments/core/services/images.dart';
import 'package:flutter_experiments/features/user/ui/provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_experiments/features/user/ui/widget/unlink_button.dart';
import 'package:provider/provider.dart';

class AccountDashboard extends StatelessWidget {
  const AccountDashboard({super.key});

  Widget profileContainer(ColorScheme color, Userprovider userprovider) {
    final user = userprovider.userDomain;
    if (user == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Center(
        child: SizedBox(
          height: 150,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: color.primary,
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: user.profileimage == null
                      ? AssetImage(ImageService.placeholder)
                      : CachedNetworkImageProvider(user.profileimage!),
                ),
              ),
              Flexible(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    user.name.isEmpty ? 'user' : user.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),

                  subtitle: Text(
                    user.email.isEmpty ? 'user' : user.email,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget lougoutbutton(Userprovider user, BuildContext context) {
    return TextButton(
      onPressed: () {
        user.logout();
        Navigator.pop(context);
      },
      child: const Text('Log Out'),
    );
  }

  Widget googlelink(
    ColorScheme color,
    Userprovider providr,
    BuildContext context,
  ) {
    Widget leading() {
      return Image.asset(ImageService.google, height: 40);
    }

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Material(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: ListTile(
          onTap: () async {
            if (!providr.islinked) {
              await providr.linkwithGoogle();
            }
          },
          contentPadding: const EdgeInsets.all(6),
          leading: Padding(padding: EdgeInsets.zero, child: leading()),
          title: Padding(
            padding: EdgeInsets.zero,
            child: Text(
              providr.islinked
                  ? 'Google Account Linked'
                  : 'Connect to Google Account',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.zero,
            child: Text(
              providr.islinked
                  ? 'Linked successfully — no further action needed'
                  : 'Sync your account with Google',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            ),
          ),
          trailing: providr.islinked
              ? Text(
                  "Linked",
                  style: TextStyle(fontSize: 12, color: Colors.green),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 2),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFB71C1C),
                        width: 2,
                      ),
                      backgroundColor: const Color(0xFFB71C1C),
                    ),

                    onPressed: () async {
                      await providr.linkwithGoogle();
                    },
                    child: Text('Link', style: TextStyle(color: Colors.white)),
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
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
                profileContainer(color, user),
                Divider(thickness: 1.5),
                googlelink(color, user, context),
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
