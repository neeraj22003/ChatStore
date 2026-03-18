import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/search/domain/search_item_domain.dart';

import 'package:flutter_experiments/features/search/ui/provider/bottomsheet_provider.dart';

import 'package:flutter_experiments/features/search/ui/widgets/bottom_sheet.dart';

import 'package:provider/provider.dart';

class ItemsCard extends StatelessWidget {
  final List<SearchDomain> results;
  final int index;
  const ItemsCard({super.key, required this.results, required this.index});
  @override
  Widget build(BuildContext context) {
    final bottomsheet = CustomBottommodalSheet();

    final bottomsheetprovider = context.read<BottomsheetProvider>();

    double price = results[index].price;

    Widget titleTile() {
      return Expanded(
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 30, right: 10),
          trailing: Text('₹$price', style: TextStyle(fontSize: 15)),

          tileColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          onTap: () {
            bottomsheet.sheet(context, results[index], bottomsheetprovider);
          },

          title: Text(
            results[index].title,
            maxLines: 1,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
    }

    Widget itemImage() {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),

        child: Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(results[index].imageUrl),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () async {
        bottomsheetprovider.reset();

        bottomsheet.sheet(context, results[index], bottomsheetprovider);
      }, //here
      child: Material(
        elevation: 2,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.all(const Radius.circular(8)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [itemImage(), titleTile()],
        ),
      ),
    );
  }
}
