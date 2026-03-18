
import 'package:flutter/material.dart';

import 'package:flutter_experiments/features/auth/ui/provider/auth_provider.dart';
import 'package:flutter_experiments/features/auth/ui/screen/signup_page.dart';

import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget{
  
const  LoginForm({super.key});
  
  Widget smallimage(){
    return SizedBox(
      height: 250,
      child: Center(
        child: Image.asset('assets/login.png'),
      )
    );
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
  Widget userfield(Authprovider provider){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
      
        validator: (value) {
        
          if(value!.isEmpty){
            return 'field are empty';
          }
          final emailformat=RegExp(r'^[^@]+@[^@]+\.[^@]+$');
          if(!emailformat.hasMatch(value)){
            return 'enter valid email';
          }
          return null;
        },
        controller: provider.namecontroller,
         textInputAction: TextInputAction.next,
        decoration: InputDecoration(
       hintText: 'Email@',
         border: InputBorder.none,
         
         focusedErrorBorder: errorborder(),
         errorBorder: errorborder(),
          enabledBorder:normalborder(),
          focusedBorder: normalborder()
        )
      ),
    );
  }

  Widget passwordfield(BuildContext context,Authprovider auth){
    return Padding(padding:const EdgeInsets.only(
      top: 8,bottom: 16,left: 8,right: 8,
      ),
      child: TextFormField  (
        validator: (value) {
          if(value!.isEmpty){
            return 'Please enter password';
          }
          return null;
        },
        controller: auth.passwordcontroller,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (value)=>_login(auth,context),
       decoration: InputDecoration(
        hintText: 'Password',
        focusedErrorBorder: errorborder(),
         errorBorder: errorborder(),
          enabledBorder:normalborder(),
          focusedBorder: normalborder()
      ),
     ),
    );
  }
  Widget loginbutton(Authprovider auth,BuildContext context){
    return ElevatedButton(onPressed: (){
      _login(auth, context);
     
       
        
      
    },
      
    
     child: Text('Login')
    );
  
  
  }
  Future<void> _login(Authprovider auth,BuildContext context)async{
  
  if(auth.formkey.currentState!.validate()){
    auth.loding();
  
   final error= await  auth.login(auth.namecontroller.text.trim(),auth.passwordcontroller.text.trim());
   
    if(error!=null){
      auth.stoploading();
    await  Future.delayed(const Duration(milliseconds: 200),);
    
        auth.snacbarkey.currentState?.showSnackBar(
          SnackBar(content: Text(error),
          backgroundColor: const Color.fromARGB(255, 144, 25, 66),
          ),
         
        );
      }else{

      }}
      
  }
  Widget signupbutton(BuildContext context){
    return ElevatedButton(
      onPressed: (){
        Navigator.push(context,
        MaterialPageRoute(builder: (context)=>SignupPage())
         );

    }, child: Text('Sign Up')
    );
  }
 
 @override
  Widget build(BuildContext context) {
    return Consumer<Authprovider>(
      builder:(context,auth,child){
       return Scaffold(
        body: SingleChildScrollView(
          child: 
          Form(key:auth.formkey ,
            child:
           Column(
         children: [
          const SizedBox(height: 50,),
          smallimage(),
         userfield(auth),
         passwordfield(context,auth),
         loginbutton(auth,context),
         const SizedBox(height: 10,),
         signupbutton(context),
          const SizedBox(height: 20,),
          
        ])
      ),)
    );
   }
  );
 }
}