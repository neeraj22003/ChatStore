
import 'package:flutter/material.dart';




class SearchbarProvider extends ChangeNotifier{

 final  TextEditingController _controller=TextEditingController();

  
  TextEditingController get controller=>_controller;

  void clearfield(){
    controller.clear();
    notifyListeners();
  }

  void trigger()async{
   notifyListeners();
   }

  void onSubmitted(String controler){
    controler=_controller.text;
    notifyListeners();
  }
 




  
}