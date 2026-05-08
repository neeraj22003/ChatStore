import 'package:chat_shop/src/core/services/currency_service.dart';
import 'package:chat_shop/src/core/widgets/itembuilder.dart';
import 'package:chat_shop/src/core/widgets/product_card.dart';

import 'package:chat_shop/src/features/search/ui/widgets/feed.dart';
import 'package:flutter/material.dart';

import 'package:chat_shop/src/features/search/data/search_repo.dart';
import 'package:chat_shop/src/features/search/domain/search_item_domain.dart';
import 'package:chat_shop/src/features/search/ui/provider/searchbar_provider.dart';

import 'package:chat_shop/src/features/search/ui/widgets/items_card.dart';

import 'package:provider/provider.dart';


class ItemLoader extends StatelessWidget {
  const ItemLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchbarProvider>();

    Future<List<SearchDomain>> loadItems() {
      if (provider.controller.text.isEmpty && provider.id != null) {
        return SearchRepo().getcategoryitem(provider.id!);
      } else {
        return SearchRepo().searchItems(provider.controller.text.trim());
      }
    }

    if (provider.controller.text.isEmpty && provider.id == null) {
      return const SliverToBoxAdapter(child: Fedsection());
    } else {
      return SliverToBoxAdapter(
        child: Itembuilder(
          waitingWidget: ProductCard(onTap: (){},
           isloading: true),
          future: loadItems(),
          itemBuilder: (context, item,) {
          
            return ItemsCard(results: item);

          },
        ),
      );
    }
  }
}

