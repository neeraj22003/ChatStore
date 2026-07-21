import 'package:chat_shop/src/features/auth/cubit/auth_cubit.dart';
import 'package:chat_shop/src/features/auth/domain/auth_domain.dart';
import 'package:chat_shop/src/features/auth/ui/widgets/custom_field.dart';
import 'package:chat_shop/src/features/auth/ui/widgets/error_box.dart';
import 'package:chat_shop/src/features/auth/ui/widgets/heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahih_validator/sahih_validator.dart';

class SignUpView extends StatefulWidget {
  final VoidCallback onclicklogin;
  final String? error;
  const SignUpView({
    super.key,
    required this.onclicklogin,
    required this.error,
  });

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String? _name, _email, _password, _address, _phone;
  final _key = GlobalKey<FormState>();
  bool _obscure = true;

  Widget name() {
    return CustomField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Fill Name Here Please';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      hintext: 'Name',
      onSaved: (p0) => _name = p0,
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
      onSaved: (value) => _email = value,

      textInputAction: TextInputAction.next,
      hintext: 'Email@',
    );
  }

  Widget address() {
    return CustomField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Fill Address Please';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      hintext: 'Home Address',
      onSaved: (p0) => _address = p0,
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
      obscureText: _obscure,
      suffixicon: IconButton(
        onPressed: () {
          setState(() {
            _obscure = !_obscure;
          });
        },
        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
      ),
      textInputAction: TextInputAction.done,
      hintext: 'Password',
      onSaved: (p0) => _password = p0,
      onfieldsubmitted: (value) {},
    );
  }

  Widget phone(BuildContext context) {
    return CustomField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Fill Your mobile number';
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      hintext: 'phone',
      maxlength: 10,
      onSaved: (p0) => _phone = p0,
      onfieldsubmitted: (p0) async {
        await _signUpFunction();
      },
    );
  }

  Widget signupbutton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () async {
          await _signUpFunction();
        },
        child: Text('Sign Up'),
      ),
    );
  }

  Widget loginbutton(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onclicklogin,
      child: Text('Log In'),
    );
  }

  Future<void> _signUpFunction() async {
    if (_key.currentState!.validate()) {
      _key.currentState?.save();
      final user = AuthDomain(
        address: _address!,
        name: _name!,
        password: _password,
        phone: _phone!,
        email: _email!,
      );
      await context.read<AuthCubit>().signup(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          const SizedBox(height: 20),
          ErrorBox(error: widget.error),
          Heading(yourHeading: 'Sign Up'),

          name(),
          userEmailfield(),
          passwordfield(),

          address(),
          phone(context),
          signupbutton(context),
          loginbutton(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
