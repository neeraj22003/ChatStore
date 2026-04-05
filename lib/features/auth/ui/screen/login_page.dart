import 'package:flutter/material.dart';

import 'package:flutter_experiments/features/auth/ui/provider/auth_provider.dart';
import 'package:flutter_experiments/features/auth/ui/screen/loading_screen.dart';
import 'package:flutter_experiments/features/auth/ui/widgets/layoout_widget.dart';
import 'package:flutter_experiments/features/auth/ui/widgets/login_form.dart';

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
