import 'package:flutter/material.dart';
import 'package:flutter_experiments/core/services/images.dart';

import 'package:flutter_experiments/features/auth/ui/provider/auth_provider.dart';
import 'package:flutter_experiments/features/auth/ui/screen/signup_page.dart';
import 'package:flutter_experiments/features/auth/ui/widgets/custom_field.dart';

import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey = GlobalKey<FormState>();
  String? email, password;
  bool obscure = false;
  Widget smallimage() {
    return SizedBox(
      height: 250,
      child: Center(child: Image.asset(ImageService.login)),
    );
  }

  Widget userfield() {
    return CustomField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'field are empty';
        }
        final emailformat = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
        if (!emailformat.hasMatch(value)) {
          return 'enter valid email';
        }
        return null;
      },
      onSaved: (p0) => email = p0,

      textInputAction: TextInputAction.next,
      hintext: 'Email@',
    );
  }

  Widget passwordfield(Authprovider provider) {
    return CustomField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter password';
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
      onfieldsubmitted: (value) {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          provider.login(email!, password!);
        }
      },
    );
  }

  Widget loginbutton(Authprovider provider) {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          provider.login(email!, password!);
        }
      },

      child: Text('Login'),
    );
  }

  Widget signupbutton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupPage()),
        );
      },
      child: Text('Sign Up'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Authprovider>(
      builder: (context, auth, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  smallimage(),
                  userfield(),
                  passwordfield(auth),
                  loginbutton(auth),
                  const SizedBox(height: 10),
                  signupbutton(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
