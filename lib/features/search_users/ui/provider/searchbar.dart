import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/chats_history/ui/providers/privider.dart';

class ChatsearchBar extends StatelessWidget {
  final ChatProvider provider;
  const ChatsearchBar({super.key,required this.provider});

  Widget searchIcon() {
    return IconButton(onPressed: () {
      provider.onsumbmitted();
    }, icon: const Icon(Icons.search));
  }

  Widget searchfield(){
    return Flexible(
      child: TextField(
        
        controller:provider.controller,
        onSubmitted: (value)=>provider.onsumbmitted(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          hintText: 'Search Users...',
          border: OutlineInputBorder(borderSide: BorderSide.none)
        ),
      )
    );
  }
  Future <String?> image() async {
  final currenuser= FirebaseAuth.instance.currentUser;
  return currenuser!.photoURL;
}
  Widget erasebutton(){
    return IconButton(onPressed: ()async{
      provider.clearfiled();
     String? url=await image();
      print('url=$url');
    },
     icon: const Icon(Icons.close));
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        clipBehavior: Clip.hardEdge,
        elevation: 0.8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(const Radius.circular(20)),
        ),
        color: color.surfaceContainerHighest,
        child: Row(children: [
          searchIcon(),
          searchfield(),
          erasebutton()
          ]),
      ),
    );
  }
}
