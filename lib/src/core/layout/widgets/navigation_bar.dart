import 'package:flutter/material.dart';
import 'package:flutter_experiments/core/layout/providers/navigation_provider.dart';


class Navigation{
  final List<NavigationDestination>  _navigationDestination=[
    NavigationDestination(icon: const Icon(Icons.search), label: 'Search'),
    NavigationDestination(icon: const Icon(Icons.person), label: 'Users'),
    NavigationDestination(icon: const Icon(Icons.chat), label: 'Chats'),
    NavigationDestination(icon: const Icon(Icons.shopping_cart), label: 'Orders')
  ];
  final List<NavigationRailDestination> _navigationRailDestination=[
    NavigationRailDestination(icon: const Icon(Icons.search), label: Text('Search')),
    NavigationRailDestination(icon: const Icon(Icons.person), label: Text('Users')),
    NavigationRailDestination(icon: const Icon(Icons.chat), label: Text('Chats')),
    NavigationRailDestination(icon: const Icon(Icons.shopping_cart), label: Text('Orders'))
  ];
  Widget bottomNavigation(BuildContext context,NavigationProvider provider){
  
   return 
    NavigationBar(
     destinations: _navigationDestination,
     selectedIndex: provider.selectedindex,
     onDestinationSelected: provider.ontapbottom,
    );
 }
  Widget navigationRail(BuildContext context,NavigationProvider provider){
    final width=MediaQuery.of(context).size.width;
    final themecolor=Theme.of(context).colorScheme;
    return 
     NavigationRail(
      scrollable: true,
       backgroundColor: themecolor.surfaceContainer,
       minWidth:width>850?160:120 ,
       destinations: _navigationRailDestination,
       selectedIndex: provider.selectedindex,
       onDestinationSelected: provider.ontapbottom,
     );
  }

}