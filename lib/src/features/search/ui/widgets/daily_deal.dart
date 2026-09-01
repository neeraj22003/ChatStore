import 'package:chat_shop/src/core/widgets/itembuilder.dart';
import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:chat_shop/src/features/search/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';

class DailyDeals extends StatelessWidget {
  final List<SearchDomain> list;
  const DailyDeals({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Daily Deals',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
            Itembuilder(
              items: list,
              itemBuilder: (context, prodouct) {
                return ProductCard(
                  isloading: false,
                  imageUrl: prodouct.imageUrl,
                  title: prodouct.title,
                  price: prodouct.inrprice,
                );
              },
            ),
          ],
        ),
      ),
    );
    
  }
}
