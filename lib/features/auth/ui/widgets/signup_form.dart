import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_experiments/features/auth/ui/provider/auth_provider.dart';
import 'package:flutter_experiments/features/auth/ui/widgets/custom_field.dart';

import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  String? _name, _email, _password, _address, _phone;
  final _formkey = GlobalKey<FormState>();
  bool _loading = false;
  bool _obscure = true;

  @override
  void dispose() {
    _loading = false;
    super.dispose();
  }

  Widget heading() {
    return Center(
      child: Stack(
        children: [
          Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 49,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..color = const Color.fromARGB(255, 219, 150, 173)
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2,
            ),
          ),
          Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 49,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 137, 203, 221),
            ),
          ),
        ],
      ),
    );
  }

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

  Widget email() {
    return CustomField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Fill Email here Please';
        }
        final emailregx = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
        if (!emailregx.hasMatch(value)) {
          return 'Enter valid email please';
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      hintext: '@Email',
      onSaved: (p0) => _email = p0,
    );
  }

  Widget password() {
    return CustomField(
      validator: (value) {
        if (value!.length < 6) {
          return 'Password should has atleast 6 characters';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      hintext: 'Password',
      obscureText: _obscure,
      suffixicon: IconButton(
        onPressed: () {
          setState(() {
            _obscure = !_obscure;
          });
        },
        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
      ),
      onSaved: (p0) => _password = p0,
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

  Widget phone(Authprovider auth, BuildContext context) {
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
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          _loading = true;
          auth.getsavingdata(_name, _email, _address, _phone);

          await auth.signUp(_email ?? '', _password ?? '', context);
        }
      },
    );
  }

  Widget signupbutton(BuildContext context, Authprovider auth) {
    return ElevatedButton(
      onPressed: () async {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          _loading = true;
          auth.getsavingdata(_name, _email, _address, _phone);
          auth.signUp(_email ?? '', _password ?? '', context);
        }
      },

      child: Text('Sign Up'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Authprovider>(
      builder: (context, auth, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  heading(),
                  name(),
                  email(),
                  password(),

                  address(),
                  phone(auth, context),
                  _loading
                      ? CircularProgressIndicator()
                      : signupbutton(context, auth),
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
