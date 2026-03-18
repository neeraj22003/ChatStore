import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/search/ui/provider/searchbar_provider.dart';

import 'package:provider/provider.dart';

class SearchBaar extends StatelessWidget{
   const SearchBaar({super.key});

 Widget searchbutton(VoidCallback onsearch){
    return  IconButton(onPressed:onsearch , 
          icon: const Icon(Icons.search),
    );
  }

  Widget textfield(TextEditingController controller, void Function(String) onSubmitted){
    return Expanded(
        child:TextField(
          onSubmitted: onSubmitted,
          controller:controller ,
            decoration: const InputDecoration(
             hintText: 'Search',
              border: InputBorder.none
          ),
      ),
    );
  }

  Widget removebutton(void Function() ontap){
    return IconButton(
      onPressed: (){
       ontap();
     
      }, 
      icon: const Icon(Icons.close),
    );
  }
  @override
  Widget build(BuildContext  context) {
   final provider=context.watch<SearchbarProvider>();
  final color=Theme.of(context).colorScheme;
    return SliverToBoxAdapter(
      child: 
    Padding(
      padding: const EdgeInsets.only(top:7 ),
    
      child: 
       Card(
     shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.all(const Radius.circular(7))
     ), 
      color:color.surfaceContainer ,
      child: Row(
        children: [
         searchbutton(provider.trigger),
         textfield(provider.controller,provider.onSubmitted),
         removebutton(provider.clearfield)
          

        ],
       ),
      )
    )
    );
    
  }
}