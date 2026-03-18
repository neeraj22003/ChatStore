import 'package:flutter/material.dart';
import 'package:flutter_experiments/features/search/domain/search_item_domain.dart';

class CartItem extends StatelessWidget {
  final SearchDomain details;
  const CartItem({required this.details, super.key});

  Widget image(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        bottomLeft: Radius.circular(8),
      ),
      child: SizedBox(
        height: width < 243 ? 30 : 80,
        width: width < 243 ? 20 : 100,
        child: Image.network(
          details.imageUrl,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 0, top: 6, bottom: 6),
      child: Text(
        textAlign: TextAlign.start,
        details.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  Widget titleandprice(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(fit: FlexFit.loose, child: title(context)),
          Flexible(fit: FlexFit.loose, child: price(context)),
        ],
      ),
    );
  }

  Widget price(BuildContext context) {
    final unitprice = details.inrprice;
    final total = ((unitprice! * details.quantity)).toStringAsFixed(1);
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 0),
      child: Text(
        '₹$total',
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: width < 243 ? 10 : 14,
        ),
      ),
    );
  }

  Widget quantitynum() {
    return Positioned(
      top: 60,
      left: -8,
      child: CircleAvatar(
        radius: 13,
        child: Center(child: Text('${details.quantity}')),
      ),
    );
  }

  Widget itemrow(ColorScheme theme, BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          elevation: 0.5,
          color: theme.surfaceContainerHigh,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.all(const Radius.circular(8)),
          child: Row(children: [image(context), titleandprice(context)]),
        ),
        quantitynum(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return itemrow(theme, context);
  }
}
