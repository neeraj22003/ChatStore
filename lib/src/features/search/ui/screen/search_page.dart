import 'package:flutter/material.dart';
import 'package:chat_shop/src/features/search/ui/widgets/header.dart';
import 'package:chat_shop/src/features/search/ui/widgets/item_loader.dart';

import 'package:chat_shop/src/features/search/ui/widgets/searchbar.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [Header(), SearchBaar(), ItemLoader()]);
  }
}
