import 'package:flutter/material.dart';

import 'package:flutter_experiments/features/chats_history/ui/screen/history_chat.dart';
import 'package:flutter_experiments/features/search_users/ui/screen/users_page.dart';


import 'package:flutter_experiments/features/orders/ui/screen/orderpage.dart';
import 'package:flutter_experiments/features/search/ui/screen/search_page.dart';

class NavigationProvider extends ChangeNotifier{
int _selectedindex=0;
int get selectedindex=>_selectedindex;
 final List<Widget> _pages=[
   Search(),
   UsersPage(),
   AdaptiveHistoryPage(),
    Orderpage()
  ];
 bool _iscart=true; 
 bool get iscart=>_iscart;
 final  GlobalKey<ScaffoldState> scaffoldkey=GlobalKey<ScaffoldState>();

 Widget get pages=>_pages[selectedindex];

 
void openendrawer(bool bool){
  _iscart=bool;
  notifyListeners();
  scaffoldkey.currentState!.openEndDrawer();
}

void closedrwaer(bool bool){
  _iscart=bool;
  notifyListeners();
  scaffoldkey.currentState?.closeEndDrawer();
}

 void ontapbottom(int index){
  _selectedindex=index;
  notifyListeners();
 }
}