
import 'package:chat_shop/src/core/widgets/circle_image.dart';

import 'package:flutter/material.dart';

class HistoryChatCard extends StatelessWidget {
  final String name;
  final String message;
  final String chatid;
  final ValueNotifier<String> selectedchatid;
  final VoidCallback onTap;
  final String? profileimage;
  final String placeholder;

  const HistoryChatCard({
    super.key,
    required this.name,
    required this.selectedchatid,
    required this.message,
    required this.profileimage,
    required this.chatid,
    required this.onTap,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return ValueListenableBuilder(
      valueListenable: selectedchatid,
      builder: (context, value, child) {
        return Material(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          clipBehavior: Clip.hardEdge,
          color: value == chatid ? color.surfaceContainerHighest : Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: CircleImage(
                    image: profileimage,
                    placeholderImage: placeholder,
                  ),
                  title: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    message,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 75.0, right: 8,bottom: 5),
                  child: const Divider(height: 1,color: Color.fromARGB(255, 131, 130, 130),),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

