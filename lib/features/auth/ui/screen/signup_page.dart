import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/auth/ui/widgets/signup_form.dart';


class SignupPage extends StatelessWidget{
  const SignupPage({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth>600){
         return  Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: double.infinity,
                  child: Image.asset('assets/widelogin.jpg', fit: BoxFit.cover),
                ),
              ),
              VerticalDivider(
                color:Color.fromARGB(255, 173, 206, 233),
                width: 1,
              ),
              
              Expanded(child: SignupForm()),

            ],
          );
        }else{
          return SignupForm();
        }
      },
    );
  }
}