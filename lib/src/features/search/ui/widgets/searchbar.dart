import 'package:chat_shop/src/core/widgets/searchbar.dart';
import 'package:chat_shop/src/features/search/ui/constants/search_hints.dart';
import 'package:chat_shop/src/features/search/ui/provider/searchbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSearchBaar extends StatelessWidget {
  const HomeSearchBaar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchbarProvider>();
    return SliverToBoxAdapter(child: 
     CustomSearchbar(
      onSearch: () {
        provider.onsubmitted();
      },
      animatedHints: hints,
      textFieldcontroller: provider.controller,
      hintText:provider.category,
      onremove: provider.clearfield,
      iscategoryactive: provider.categoryactive,
    ));
  }
}
