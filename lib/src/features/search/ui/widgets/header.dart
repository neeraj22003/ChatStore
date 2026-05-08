import 'package:chat_shop/src/features/search/ui/provider/searchbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Consumer<SearchbarProvider>(
      builder: (context,provider,child)
      => SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:provider.category==null &&provider.controller.text.isEmpty? Text(
              'Daily Deals',
              style: TextStyle(
                fontSize: 18,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w900,
              ),
            ):const SizedBox.shrink(),
      ),
    ));
  }
}
