import 'dart:math';

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
    Future<List<SearchDomain>?> loadItems(SearchbarProvider provider) {
  if (provider.controller.text.isEmpty && provider.id != null) {
    return SearchRepo().getcategoryitem(provider.id!);
  } else {
    return SearchRepo().searchItems(provider.controller.text.trim());
  }
}
    return FutureBuilder(
            future:loadItems(provider),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text(snapshot.error.toString())),
                );
              }
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final item = snapshot.data!;

                return SliverPadding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  sliver: ItemsList(results: item),
                );
              }
              if(!snapshot.hasData&&provider.id!=null||provider.controller.text.isNotEmpty){
                return  SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(child: Text('')),
                ),
              );
              }

              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(child: Text('')),
                ),
              );
            },
          );
  }
}

class ItemsList extends StatelessWidget {
  final List<SearchDomain> results;

  const ItemsList({super.key, required this.results});
  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final crossaxiscount = max(1, constraints.crossAxisExtent ~/ 264);
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.0,
            mainAxisExtent: 100,
            
            crossAxisCount: crossaxiscount,
          ),
          delegate: SliverChildBuilderDelegate(childCount: results.length, (
            BuildContext context,
            int index,
          ) {
            return ItemsCard(results: results[index]);
          }),
        );
      },
    );
  }
}
