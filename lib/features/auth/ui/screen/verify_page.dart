

import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/auth/ui/provider/auth_provider.dart';


import 'package:provider/provider.dart';


class VerifyPage extends StatelessWidget {
  const VerifyPage({super.key});


  
 
  Widget message(BuildContext context) {
    final userEmail = context.read<Authprovider>();
    return Text(
      'We’ve sent a verification link to your email ${userEmail.createdemail}. '
      'Please check your inbox or "spam" folder and verify before continuing.',
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    );
  }

  Widget indicator() {
    return Consumer<Authprovider>(
      builder: (context, auth, child) {
        if (auth.verified) {
         Future.delayed(const Duration(seconds: 3),(){
          
          if(context.mounted&&Navigator.canPop(context)){
            Navigator.pop(context);
            // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home()));
          }
         });
        return  const Icon(Icons.task_alt, color: Colors.green, size: 50);
       
        }
       return const LinearProgressIndicator();
      },
    );
  }

  Widget messageBox(BuildContext context) {
   
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:Container(
        constraints: BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [message(context), const SizedBox(height: 20), indicator()],
            ),
          ),
        ),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child:SingleChildScrollView(
        child:  Column(
         children: [
          SizedBox(
              height: 250,
              child: Image.asset('assets/email.png'),
            
            ),
          const SizedBox(height: 18),
          messageBox(context),
        ],
      ),))
    );
  }
}
