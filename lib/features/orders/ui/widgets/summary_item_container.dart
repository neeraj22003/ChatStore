import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/orders/ui/providers/order_provider.dart';

class SummaryItemContainer extends StatelessWidget {
  final OrderProvider provider;
  final int index;

 
  const SummaryItemContainer({super.key,required this.provider,required this.index});
  
  double height(List item, int count, double width) {
    if (item.length > 1 && count == 1 && width > 227) {
      return item.length * 70;
    } else if (count > 1 && width > 227) {
      return item.length / count * 73;
    } else if (width < 227) {
      return 70;
    }
    return 70;
  }

  Widget title(Map<String,dynamic> item) {
    final totalrate=item['inrprice']*item['quantity'];
    return Expanded(
      child: ListTile(
        title: Text(item['title']??'',style: TextStyle(fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis),maxLines: 1,),
        subtitle: Text('Qnt:${item['quantity']??1}', style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500)),
        trailing: Text('₹${totalrate!.toStringAsFixed(1)}',style: TextStyle(fontSize: 15),),
      ),
    );
  }

  Widget image(Map<String,dynamic> item) {
    return SizedBox(
      height: double.infinity,
      width: 70,
      child: ClipRRect(
        borderRadius:const BorderRadiusGeometry.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
        child:  Image.network(item['imageUrl']??"", fit: BoxFit.cover),
    ));
  }
  Widget card(Map<String,dynamic>oder,int i){
     final item=oder['items'][i];
    return Material(
   
      clipBehavior: Clip.hardEdge,

      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child:
        Row(children: [image(item), title(item)]),
    );
  }
  @override
  Widget build(BuildContext context) {
    final oder=provider.oders[index];
    final item=oder['items']as List<dynamic>;
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final count = max(1, constraints.maxWidth ~/ 300);          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 250),
            child: SizedBox(
              height: height(item, count, constraints.maxWidth),
              child: GridView.builder(
                scrollDirection: constraints.maxWidth < 227
                    ? Axis.horizontal
                    : Axis.vertical,
                padding: const EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  mainAxisExtent: constraints.maxWidth < 227 ? 200 : 70,
                  
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: item.length,
                itemBuilder: (context, i) {
                  return card(oder,i);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  


}
