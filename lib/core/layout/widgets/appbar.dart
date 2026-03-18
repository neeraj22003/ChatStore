import 'package:flutter/material.dart';


import 'package:flutter_experiments/core/layout/providers/appbar_provider.dart';
import 'package:flutter_experiments/core/layout/providers/navigation_provider.dart';
import 'package:flutter_experiments/features/auth/ui/provider/auth_provider.dart';

import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar( {super.key});
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context).colorScheme;
    return Consumer3<Appbarprovider,Authprovider,NavigationProvider>(
      builder: (context,provider,auth,navi,child){
        return AppBar(
     title: Text('Store',
     style: TextStyle(fontWeight: FontWeight.w700),
    ),
     backgroundColor: theme.surfaceContainer,
     actions: [
      IconButton(
        onPressed:(){
         provider.themefuction();
        //  provider.reset();
        } ,
         icon: provider.thememode==ThemeMode.dark?
           const Icon(Icons.light_mode):const Icon(Icons.dark_mode),
          ),
         const SizedBox(width: 4,),
         IconButton(onPressed: (){
          navi.openendrawer(false);
         }, icon: const Icon(Icons.person,),)
         ],
       );
      }
    );
  }
  
  @override
  
  Size get preferredSize =>Size.fromHeight(56);
}