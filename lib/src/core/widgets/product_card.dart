import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  final VoidCallback ontap;
  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.ontap,
  });

  Widget imagebox(ColorScheme color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 90,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: color.primary, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image),
            ),
          ),
        ),
      ),
    );
  }

  Widget titlebox() {
    return SizedBox(
      width: 160,
      
        child: Text(
          title,
          style: TextStyle(fontSize: 15),
          overflow: TextOverflow.ellipsis,
        ),
      
    );
  }

  Widget pricebox() {
    return Text(
      '₹${price.toStringAsFixed(1)}',
      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return  Material(clipBehavior: Clip.antiAlias,
    color: Colors.grey.withOpacity(0.15),
    borderRadius: const BorderRadius.all(Radius.circular(25)),
      child:InkWell(
      onTap: ontap,child: 
       Padding(
        padding: const EdgeInsets.only(left: 8,right: 8),
        child:Row(
            children: [imagebox(color), titlebox(), const Spacer(), pricebox()],
          ),
        ),
      ));
  }
}
