
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_experiments/features/auth/ui/provider/auth_provider.dart';
import 'package:flutter_experiments/features/auth/ui/screen/login_page.dart';
import 'package:flutter_experiments/features/auth/ui/screen/verify_page.dart';

import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone=TextEditingController();
 
  final _formkey = GlobalKey<FormState>();
  bool _loading=false;
  @override
  void dispose() {
    _name.dispose();
    _password.dispose();
    _email.dispose();
    _address.dispose();
    _loading=false;
    super.dispose();

  }
 void loading(String name,String email,String password,String address,String phone ){
  if(name.isNotEmpty && email.isNotEmpty&&password.isNotEmpty&&address.isNotEmpty&&phone.isNotEmpty){
    setState(() {
      _loading=true;
    });
  }
 }
  OutlineInputBorder normalborder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 1.2),
      borderRadius: const BorderRadius.all(Radius.circular(15)),
    );
  }

  OutlineInputBorder errorborder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.2),
      borderRadius: const BorderRadius.all(Radius.circular(15)),
    );
  }

  InputDecoration inputdecoration(String hinttext) {
    return InputDecoration(
      hintText: hinttext,
      border: InputBorder.none,
      errorBorder: errorborder(),
      focusedErrorBorder: errorborder(),
      enabledBorder: normalborder(),
      focusedBorder: normalborder(),
    );
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
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 8, right: 90, left: 8),
      child: TextFormField(
        controller: _name,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Fill Name Here Please';
          }
          return null;
        },
        decoration: inputdecoration('Name'),
      ),
    );
  }

  Widget email() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _email,
        textInputAction: TextInputAction.next,
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
        decoration: inputdecoration('Email@'),
      ),
    );
  }

  Widget password() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 90, left: 8),
      child: TextFormField(
        controller: _password,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value!.length < 6) {
            return 'Password should has atleast 6 characters';
          }
          return null;
        },
        decoration: inputdecoration('Password'),
      ),
    );
  }
  Widget phone(Authprovider auth){
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 30, right: 90, left: 8),
      child: TextFormField(
        controller:_phone,
        maxLength: 10,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      
        onFieldSubmitted: (value) { 
          _sumbitform(context, auth);
          loading(_name.text, _email.text, _password.text,
           _address.text, _phone.text);
          },
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Fill Your mobile number';
          }
          return null;
        },
        decoration: inputdecoration('Phone'),
      ),
    );
  }
  Widget address() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 20, right: 8, left: 8),
      child: TextFormField(
        controller: _address,
        
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Fill Address Please';
          }
          return null;
        },
        decoration: inputdecoration('Home address'),
      ),
    );
  }

  Widget signupbutton(BuildContext context, Authprovider auth) {
    return ElevatedButton(
      onPressed: () async {
        _sumbitform(context, auth);
        loading(_name.text, _email.text, _password.text, _address.text, _phone.text);
      },
       
      child: Text('Sign Up'),
    );
  }

  Future<void> _sumbitform(BuildContext context, Authprovider auth) async {
    if (_formkey.currentState!.validate()) {
      final error = await auth.savecredentials(
        _name.text.trim(),
        _email.text.trim(),
        _password.text.trim(),
        _address.text.trim(),
        _phone.text.trim()
      );

     
      if (error == null) {
        if (!context.mounted) return;
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VerifyPage()),
        );
      } else if (error == 'email-already-in-use') {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email already registered. Please log in."),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Authprovider>(
      builder: (context, auth, child) {
        return Scaffold(
          appBar: AppBar(
            leading: 
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                icon: const Icon(Icons.arrow_back),
              
             )
            
          ),
          body: SingleChildScrollView(
            child:  Form(
            key: _formkey,
            child: Column(
              children: [
                heading(),
                name(),
                email(),
                password(),
                
                address(),
                phone(auth),
                _loading?CircularProgressIndicator():
                signupbutton(context, auth),
                 const SizedBox(height: 20,),
              ],
            ),
          ),)
        );
      },
    );
  }
}
