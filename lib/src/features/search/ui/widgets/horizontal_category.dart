import 'package:chat_shop/src/features/search/data/ebay_category.dart';
import 'package:chat_shop/src/features/search/ui/provider/searchbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizontalCategory extends StatelessWidget {
  const HorizontalCategory({super.key});

  
  Widget categorycard(
    ColorScheme color,
    int index,
    IconData icon,
    String title,
    String id,
    SearchbarProvider provider,
  ) {
    bool isselected = provider.selectedindex == index;
    return Padding(
      padding: const EdgeInsets.all(2.0),

      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(const Radius.circular(20)),
        color: isselected ? color.primaryContainer : Colors.grey.withOpacity(0.2),
        child: InkWell(
          onTap: () {
            
             
              provider.setidandName(id, title, index);
            
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(icon, color: isselected ? color.primary : null),
                Text(title),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final category = EbayCategory.list;
    final provider = context.watch<SearchbarProvider>();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            itemCount: category.length,
            itemBuilder: (context, index) {
              return categorycard(
                color,
                index,
                category[index].icon,
                category[index].name,
                category[index].id,
                provider,
              );
            },
          ),
        ),
      ),
    );
  }
}
