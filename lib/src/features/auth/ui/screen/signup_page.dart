import 'package:flutter/material.dart';
import 'package:chat_shop/src/features/auth/ui/provider/auth_provider.dart';
import 'package:chat_shop/src/features/auth/ui/screen/loading_screen.dart';
import 'package:chat_shop/src/features/auth/ui/widgets/layoout_widget.dart';
import 'package:chat_shop/src/features/auth/ui/widgets/signup_form.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<Authprovider>(
      builder: (context, auth, child) {
        return CustomLayout(
          auth: auth,
          screen: SignupForm(),
          loadingscreen: LoadingScreen(),
        );
      },
    );
  }
}
