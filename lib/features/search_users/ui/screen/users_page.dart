import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/chats_history/ui/providers/privider.dart';
import 'package:flutter_experiments/features/search_users/ui/provider/searchbar.dart';
import 'package:flutter_experiments/features/search_users/ui/widgets/userbuilder.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget{
 const  UsersPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder:(context,provider,child)=>
       CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child:  ChatsearchBar(provider: provider,),
          ),
          SliverFillRemaining(
            child: Userbuilder(query: provider.controller.text.trim(),
            ) ,
          )
        ]  
       
      
        
      )
    );
  }
}