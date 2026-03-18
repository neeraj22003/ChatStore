import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/orders/ui/providers/order_provider.dart';
import 'package:flutter_experiments/features/orders/ui/screen/order_summary.dart';

class OrderCard extends StatelessWidget {
  final OrderProvider provider;
  final int index;
  const  OrderCard({super.key,required this.provider,required this.index});
 
  Widget brandheader() {
    return Padding(
      padding: const EdgeInsets.only(left: 8,top: 8),
      child: Row(
        children: [
          SizedBox(height: 20, width: 20, child: Image.asset('assets/app.png')),
          const SizedBox(width: 5),
          Text(
            'Store',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
  Widget imagelist(ColorScheme color){
    final order=provider.oders[index];
    final item=order['items']as List<dynamic>? ?? [];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color:color.surfaceContainerHighest ,
          borderRadius: const BorderRadius.all(Radius.circular(8))
          ),
          child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: item.length,
          itemBuilder: (context,i)=>Padding(padding: const EdgeInsets.all(8),
           child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            child: Image.network(item[i]?['imageUrl']??'',fit: BoxFit.cover,),
           ),
          ),
        )
          
      ),
    );
  }

  Widget button(BuildContext context){
    return
    Align(
      alignment: Alignment.bottomRight,
      child: IconButton(
      onPressed: (){
        Navigator.push(context,MaterialPageRoute(
          builder: (context)=> OrderSummary(provider: provider, index: index)
          ) );
      }, 
      icon: const Icon(
      Icons.arrow_circle_right_outlined,
      size: 35,
     ))
    );
  }


  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context).colorScheme;
     return Material(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
       color:theme.surfaceContainer ,
        child: Column(
         children: [
          brandheader(),
           imagelist(theme),
            button(context)

        ]
        
      )
    );
  }
}
