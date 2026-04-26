import 'package:flutter/material.dart';
import 'package:chat_shop/src/core/services/images.dart';
import 'package:chat_shop/src/features/auth/ui/provider/auth_provider.dart';

class CustomLayout extends StatelessWidget {
  final Authprovider? auth;
  final Widget screen;
  final Widget? loadingscreen;

  const CustomLayout({
    super.key,
    required this.auth,
    required this.screen,
    required this.loadingscreen,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: double.infinity,
                  child: Image.asset(ImageService.widelogin, fit: BoxFit.cover),
                ),
              ),
              VerticalDivider(
                color: Color.fromARGB(255, 173, 206, 233),
                width: 1,
              ),

              Expanded(
                child: auth != null
                    ? auth!.loading
                          ? loadingscreen ?? SizedBox.shrink()
                          : screen
                    : screen,
              ),
            ],
          );
        } else {
          return auth != null
              ? auth!.loading
                    ? loadingscreen ?? SizedBox.shrink()
                    : screen
              : screen;
        }
      },
    );
  }
}
