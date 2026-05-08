import 'package:chat_shop/src/core/widgets/itembuilder.dart';
import 'package:chat_shop/src/core/widgets/product_card.dart';
import 'package:chat_shop/src/features/search/ui/widgets/items_card.dart';
import 'package:flutter/material.dart';
import 'package:chat_shop/src/features/search/data/search_repo.dart';

class Fedsection extends StatelessWidget {
  const Fedsection({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: 
           Itembuilder(
            waitingWidget: ProductCard(onTap: (){}, isloading: true),
            future: SearchRepo().feeditems(),
            itemBuilder: (context, item) {
              return ItemsCard(results: item);
            },
          ),
        
    );
  }
}
