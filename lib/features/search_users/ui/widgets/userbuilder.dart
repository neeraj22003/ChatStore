import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_experiments/core/layout/providers/navigation_provider.dart';
import 'package:flutter_experiments/features/chats/ui/screen/chat_page.dart';
import 'package:flutter_experiments/features/chats_history/ui/providers/privider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Userbuilder extends StatelessWidget{
  final String query;
  const  Userbuilder({super.key,required this.query});
  
 
 Future <QuerySnapshot>filter()async{
 
  try {
    final connection=await http.get(Uri.parse('https://www.google.com'));
    if(connection.statusCode!=200){
  throw Exception('no internet');
 }
 }on SocketException{
  throw Exception('no internet');
 }on http.ClientException{
  throw  throw Exception('no internet');
 }catch (e){
   throw Exception('something iswrong');
 }
  
  return FirebaseFirestore.instance.collection('users').
   where('query',isGreaterThanOrEqualTo: query).where('query',isLessThan: '$query\uf8ff').get();
  
}


Widget usercard(QueryDocumentSnapshot user,BuildContext context,bool isdesktop,double width){
  final color=Theme.of(context).colorScheme;
  final navigation=context.watch<NavigationProvider>();
  final chat=context.watch<ChatProvider>();
  
  return Card(clipBehavior: Clip.antiAlias,
   child:InkWell(
    onTap: () {
      final genratedchatid=chat.getchatid(user.id);
     chat.addChatidTilereciverid(user.id,user['name'],genratedchatid);
      if(isdesktop){
        navigation.ontapbottom(2);
      }else{
        chat.getchatid(user.id);
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=>ChatPage(
          secondguyid: chat.id!,
           secondguyname: chat.title!,
           chatid: chat.chatid!,
           isDesktop: isdesktop,
         
        )
       )
      );
    }},
    child: Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child:CircleAvatar(
          backgroundColor:color.primary,
          radius:width<258?17:26,
          child: 
         CircleAvatar(
        radius: width<258?15:24,
        child: Icon(Icons.person,size: 30,),
        ),)
      ),
      
      Expanded(
        child: ListTile(
          contentPadding: EdgeInsets.only(
            left: 4 ,top: 1,bottom: 1
          ),
        
          title:  Padding(
            padding: EdgeInsets.zero,
            child: Text(user['name'],overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: width<373?13:14),),
          ),
          subtitle: Padding(
            padding: EdgeInsets.zero,
            child: Text(user['email']??"noemail",
            style: TextStyle(fontSize: width<373?10:13)
            ),
          ),
          trailing:width<195?null:Padding(
            padding: const EdgeInsets.only(right: 8,bottom: 2),
            child: const Icon(Icons.chat),
          )
        ),
      ),
      
    ],
    ))
  );
}

Widget futurebuilder(){
  return FutureBuilder(future: filter(),
   builder:(context, snapshot) {
     if (snapshot.connectionState==ConnectionState.waiting){
      return Center(child:CircularProgressIndicator());
     }
    
   
     if(snapshot.hasError){
      return Center(child: Text(snapshot.error.toString()));
     }
     if(snapshot.hasData &&snapshot.data!.docs.isEmpty){
      return Center(child: Text('No User Found'),);
     }
     final users=snapshot.data!;
    return LayoutBuilder(
      builder: (context, constrainst) {
        final count=max(1,constrainst.maxWidth~/200);
        final isdesktop=constrainst.maxWidth>480;
        final cardwidth=(constrainst.maxWidth-16)/count;
        return GridView.builder(padding: const EdgeInsets.all(8),
          itemCount:users.docs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            mainAxisExtent: 80,
          
          ),
          itemBuilder: (context, index) => usercard(users.docs[index], context,isdesktop,cardwidth)
        );
      },
     );
   },
  );
}
  @override
  Widget build(BuildContext context) {
    if(query.isEmpty){
      return  Center(
        child: Center(child: SizedBox(
          height: 100,
          child: Image.asset('assets/user.png')),)
      );
    }
    return futurebuilder();
  }
}