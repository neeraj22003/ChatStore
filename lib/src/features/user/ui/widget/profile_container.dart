import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_experiments/src/core/services/images.dart';
import 'package:flutter_experiments/src/features/user/domain/user_domain.dart';

class ProfileContainer extends StatelessWidget {
  final UserDomain? user;
  const ProfileContainer({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

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
                  backgroundImage: user?.profileimage == null
                      ? AssetImage(ImageService.placeholder)
                      : CachedNetworkImageProvider(user!.profileimage!),
                ),
              ),
              Flexible(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    user?.name ?? 'user',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),

                  subtitle: Text(
                    user?.email ?? 'email',
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
}
