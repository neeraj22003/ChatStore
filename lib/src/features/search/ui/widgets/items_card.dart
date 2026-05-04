import 'package:chat_shop/src/core/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:chat_shop/src/features/search/domain/search_item_domain.dart';

import 'package:chat_shop/src/features/search/ui/provider/bottomsheet_provider.dart';

import 'package:chat_shop/src/features/search/ui/widgets/bottom_sheet.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

class ItemsCard extends StatelessWidget {
  final SearchDomain results;

  const ItemsCard({super.key, required this.results});
  @override
  Widget build(BuildContext context) {
    final bottomsheet = CustomBottommodalSheet();

    final bottomsheetprovider = context.read<BottomsheetProvider>();

    return ProductCard(
      image: results.imageUrl,
      title: results.title,
      price: results.inrprice ?? 0.0,
      ontap: (){
        HapticFeedback.heavyImpact();
        bottomsheetprovider.reset();
       
          bottomsheet.sheet(context, results, bottomsheetprovider);
        
      },
    );
  }
}
