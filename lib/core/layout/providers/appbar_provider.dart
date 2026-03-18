import 'package:flutter/material.dart';


class Appbarprovider extends ChangeNotifier{

 ThemeMode _thememode=ThemeMode.light; 
 ThemeMode get thememode=>_thememode;
 
 
 void themefuction(){
  if(_thememode==ThemeMode.light){
    _thememode=ThemeMode.dark;
  }else{
    _thememode=ThemeMode.light;
  }
  
  notifyListeners();
 }

 
 
  
 
 
}