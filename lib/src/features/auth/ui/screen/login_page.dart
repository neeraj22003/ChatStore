import 'package:flutter/material.dart';

import 'package:chat_shop/src/features/auth/ui/provider/auth_provider.dart';
import 'package:chat_shop/src/features/auth/ui/screen/loading_screen.dart';
import 'package:chat_shop/src/features/auth/ui/widgets/layoout_widget.dart';
import 'package:chat_shop/src/features/auth/ui/widgets/login_form.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Authprovider>(
      builder: (context, auth, child) {
        return CustomLayout(
          auth: auth,
          screen: LoginForm(),
          loadingscreen: LoadingScreen(),
        );
      },
    );
  }
}
