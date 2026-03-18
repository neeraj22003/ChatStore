import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';


class OrderProvider extends ChangeNotifier{

  List< Map<String,dynamic>>_orders=[];
  List< Map<String,dynamic>> get oders=>_orders;
   final userid=FirebaseAuth.instance.currentUser!.uid;
   

   OrderProvider(){
    getorder();
   }

  void addoder( Map<String,dynamic> order){
    order['orderId']??=DateTime.now().toString();
    _orders.insert(0, order);
    notifyListeners();
  }

  double totalrate(Map<String,dynamic> order,){
    double total=0.0;
    final items=order['items']as List<dynamic>;
    for(var item in items){
     final  price=double.tryParse( item['price']?['value']??0.toString());
     final qnt=item['quantity']??1;
      total += price!*qnt;
    }
    return total;
  }
  void getorder()async{
   final orders=await FirebaseFirestore.instance.collection('orders').doc(userid).collection('userorders').orderBy('createdAt',descending: true).get();
   _orders=orders.docs.map((doc){
    final data=doc.data();
    data['orderId']=doc.id;
    return data;
    }

   ).toList();
   notifyListeners();
  }

  void deleteorder(String orderid,int index)async{
    await FirebaseFirestore.instance.collection('orders').doc(userid).collection('userorders').doc(orderid).delete();
     _orders.removeAt(index);
    notifyListeners();
    }

}