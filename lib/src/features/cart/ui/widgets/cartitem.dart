import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_shop/src/core/widgets/counter_widget.dart';
import 'package:flutter/material.dart';

class Cartitem extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  final Widget? trailing;
  final ValueNotifier<int> yourquantitynotfier;

  const Cartitem({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.trailing,

    required this.yourquantitynotfier,
  });

  Widget cardimage() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.all(const Radius.circular(7)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(const Radius.circular(7)),
        child: CachedNetworkImage(imageUrl: image, fit: BoxFit.cover),
      ),
    );
  }

  Widget itemprice() {
    return ValueListenableBuilder(
      valueListenable: yourquantitynotfier,
      builder: (context, value, child) {
        return Text(
          '₹${((price) * value).toStringAsFixed(1)}',
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: yourquantitynotfier,
      builder: (context, value, child) {
        if (value > 0) {
          return ListTile(
          
            leading: cardimage(),
            title: Text(
              title,
              style: TextStyle(fontSize: 10),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: itemprice(),
            trailing: trailing,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
