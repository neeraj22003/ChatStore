import 'package:chat_shop/src/core/layout/scaffold/adaptive_layout.dart';
import 'package:chat_shop/src/core/services/images.dart';
import 'package:chat_shop/src/features/auth/ui/screen/login_view.dart';
import 'package:chat_shop/src/features/auth/ui/screen/signup_view.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  final String? error;
  const AuthScreen({super.key,required this.error});

  @override
  State<AuthScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<AuthScreen> {
  ValueNotifier<bool> isSignupview = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return CustomAdaptiveLayout(
      firstchildforbiggscreen: Image.asset(
        ImageService.widelogin,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
      pages: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: isSignupview,
          builder: ((context, value, child) {
            if (value) {
              return SignUpView(
                error: widget.error??'',
                onclicklogin: () {
                  isSignupview.value = false;
                },
              );
            } else {
              return LoginView(
                error:widget.error??'' ,
                onclickSignup: () {
                  isSignupview.value = true;
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
