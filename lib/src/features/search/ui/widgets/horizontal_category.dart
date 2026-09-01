import 'package:chat_shop/src/features/search/domain/category_domain.dart';
import 'package:flutter/material.dart';

class HorizontalCategory extends StatelessWidget {
  final List<CategoryDomain> list;
  final ValueNotifier<int?> selectedindex;
  final ValueChanged<int> onSelect;
  const HorizontalCategory({
    super.key,
    required this.list,
    required this.selectedindex,
    required this.onSelect,
  });

  Widget categorycard(
    ColorScheme color,
    int index,
    IconData icon,
    String title,
    String id,
  ) {
    return Padding(
      padding: const EdgeInsets.all(2.0),

      child: ValueListenableBuilder(
        valueListenable: selectedindex,
        builder: (context, selectedindex, child) {
          bool isselected=selectedindex==index;
          return Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.all(const Radius.circular(20)),
            color: isselected
                ? color.primaryContainer
                : Colors.grey.withValues(alpha: 0.2),
            child: InkWell(
              onTap: () {
                onSelect(index);
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
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            itemCount: list.length,
            itemBuilder: (context, index) {
              return categorycard(
                color,
                index,
                list[index].icon,
                list[index].name,
                list[index].id,
              );
            },
          ),
        ),
      ),
    );
  }
}
