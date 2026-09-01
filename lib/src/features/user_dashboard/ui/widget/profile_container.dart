import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  final String? profileImage;
  final String placeholderImage;
  final String profleTitle;
  final String profilesubtitle;
  const ProfileContainer({
    super.key,
    required this.profileImage,
    required this.placeholderImage,
    required this.profleTitle,
    required this.profilesubtitle,
  });
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
                  backgroundImage:( profileImage == null||profileImage!.isEmpty)
                      ? AssetImage(placeholderImage)
                      : CachedNetworkImageProvider(profileImage!),
                ),
              ),
              Flexible(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                   profleTitle,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),

                  subtitle: Text(
                   profilesubtitle,
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
