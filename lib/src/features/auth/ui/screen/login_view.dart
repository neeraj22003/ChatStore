import 'package:chat_shop/src/core/services/images.dart';
import 'package:chat_shop/src/features/auth/cubit/auth_cubit.dart';

import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';
import 'package:chat_shop/src/features/auth/ui/widgets/custom_field.dart';
import 'package:chat_shop/src/features/auth/ui/widgets/error_box.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahih_validator/sahih_validator.dart';

class LoginView extends StatefulWidget {
  final VoidCallback onclickSignup;
  final String? error;
  const LoginView({super.key,required this.onclickSignup,required this.error});

  @override
  State<StatefulWidget> createState() => _StateLoginView();
}

class _StateLoginView extends State<LoginView> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? email, password;
  bool obscure = false;
  Widget smallimage() {
    return SizedBox(
      height: 250,
      child: Center(child: Image.asset(ImageService.login)),
    );
  }

  Widget userEmailfield() {
    return CustomField(
      validator: (value) {
        final error = SahihValidator.email(email: value ?? '');

        if (error != null) {
          return error;
        }
        return null;
      },
      onSaved: (value) => email = value,

      textInputAction: TextInputAction.next,
      hintext: 'Email@',
    );
  }

  Widget passwordfield() {
    return CustomField(
      validator: (value) {
        final error = SahihValidator.loginPassword(password: value ?? '');
        if (error != null) {
          return error;
        }
        return null;
      },
      obscureText: obscure,
      suffixicon: IconButton(
        onPressed: () {
          setState(() {
            obscure = !obscure;
          });
        },
        icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
      ),
      textInputAction: TextInputAction.done,
      hintext: 'Password',
      onSaved: (p0) => password = p0,
      onfieldsubmitted: (value) {},
    );
  }

  Widget loginbutton() {
    return ElevatedButton(
      onPressed: () async {
        await _signInFunction();
      },
      child: Text('Login'),
    );
  }

  Widget signupbutton(BuildContext context) {
    return ElevatedButton(onPressed:widget.onclickSignup, child: Text('Sign Up'));
  }

  Future<void> _signInFunction() async {
    if (_key.currentState!.validate()) {
      _key.currentState?.save();
     await context.read<AuthCubit>().
        signIn(
          AuthDomain(
            phone: null,
            name: null,
            address: null,
            email: email!,
            password: password!,
          ),
        
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          const SizedBox(height: 50),
          ErrorBox(error: widget.error),
          smallimage(),
          userEmailfield(),
          passwordfield(),
          loginbutton(),
          const SizedBox(height: 10),
          signupbutton(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
