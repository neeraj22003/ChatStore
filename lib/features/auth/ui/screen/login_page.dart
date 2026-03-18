

import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/auth/ui/provider/auth_provider.dart';
import 'package:flutter_experiments/features/auth/ui/widgets/login_form.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Authprovider>(
      builder: (context, auth, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Image.asset(
                        'assets/widelogin.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Color.fromARGB(255, 173, 206, 233),
                    width: 1,
                  ),

                  Expanded(child: auth.loading ?Loadingloging():LoginForm()),
                ],
              );
            } else {
              return auth.loading ?Loadingloging():LoginForm();
            }
          },
        );
      },
    );
  }
}

class Loadingloging extends StatelessWidget {
  const Loadingloging({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 300),
            CircularProgressIndicator(strokeWidth: 5),
            const SizedBox(height: 5),
            Text('Loading', style: TextStyle(fontSize: 25)),
          ],
        ),
      ),
    );
  }
}
