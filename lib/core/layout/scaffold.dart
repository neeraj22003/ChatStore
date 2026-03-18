import 'package:flutter/material.dart';
import 'package:flutter_experiments/core/layout/widgets/appbar.dart';
import 'package:flutter_experiments/core/layout/widgets/navigation_bar.dart';
import 'package:flutter_experiments/features/user/ui/screen/acount_dashboard.dart';
import 'package:flutter_experiments/features/cart/ui/screen/cart_page.dart';
import 'package:flutter_experiments/features/search/ui/widgets/floating_cart_button.dart';

import 'package:flutter_experiments/core/layout/providers/navigation_provider.dart';

import 'package:provider/provider.dart';

class WideScaffolds extends StatelessWidget{
  
 const WideScaffolds({super.key});
  @override
   Widget build(BuildContext context){
    final themecolor=Theme.of(context).colorScheme;
    final provider=context.watch<NavigationProvider>();
    return Row(
         children: [
          Navigation().navigationRail(context,provider ), 
          
           VerticalDivider(
            width: 1, 
            thickness: 1, 
            color: themecolor.outlineVariant, 
             ),
            Expanded(
             child:Scaffold(
              key: provider.scaffoldkey,
            appBar:CustomAppBar(),
            body:provider.pages,
            floatingActionButton: FloatingCartButton(),
            endDrawer:Drawer(
              child: provider.iscart? CartPage():AccountDashboard(),
            ),
            
       )
      )
     ]
    ); 
   
  } 
}
class Mobilescaffold extends StatelessWidget{
  final double width;
  const Mobilescaffold({super.key,required this.width});
  
  @override
  Widget build(BuildContext context){
   // final theme=Theme.of(context).colorScheme;
      final provider=context.watch<NavigationProvider>();
   
    return Scaffold(
      key: provider.scaffoldkey,
      appBar: CustomAppBar(),
      body: provider.pages,
      floatingActionButton: FloatingCartButton(),
      bottomNavigationBar: Navigation().bottomNavigation(context, provider),
      endDrawer: Drawer(
        width: width,
        shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
          ),
        child:provider.iscart? CartPage():AccountDashboard(),
      ),

    );
  }
}