import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_experiments/core/services/images.dart';

import 'package:flutter_experiments/features/search/data/search_repo.dart';
import 'package:flutter_experiments/features/search/domain/search_item_domain.dart';
import 'package:flutter_experiments/features/search/ui/provider/searchbar_provider.dart';

import 'package:flutter_experiments/features/search/ui/widgets/items_card.dart';

import 'package:provider/provider.dart';

class ItemLoader extends StatelessWidget {
  const ItemLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchbarProvider>();
    return FutureBuilder(
      future: SearchRepo().searchItems(provider.controller.text.trim()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            provider.controller.text.isNotEmpty) {
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

        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: Image.asset(scale: 2.5, ImageService.searchItembG),
            ),
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
            mainAxisExtent: 225,
            crossAxisCount: crossaxiscount,
          ),
          delegate: SliverChildBuilderDelegate(childCount: results.length, (
            BuildContext context,
            int index,
          ) {
            return ItemsCard(results: results, index: index);
          }),
        );
      },
    );
  }
}
