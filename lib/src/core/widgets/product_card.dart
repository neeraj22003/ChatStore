import 'package:chat_shop/src/core/widgets/custom_skeleton.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String? imageUrl;
  final String? title;
  final double? price;
  final VoidCallback onTap;
  final bool isloading;
  const ProductCard({
    super.key,
    this.imageUrl,
    this.title,
    this.price,
    required this.onTap,
    required this.isloading
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double _scale = 1.0;
  Widget cardimage() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.all(const Radius.circular(7)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(const Radius.circular(7)),
        child:widget.isloading
        ? Customskeleten(height: 80, width: 80, borderadius: 7)
          
        :Image.network(widget.imageUrl??'', fit: BoxFit.cover),
      ),
    );
  }

  Widget plusicon() {
    return Positioned(
      right: 2,
      bottom: 65,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 26, 155, 67),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: widget.isloading
        ? Customskeleten(height: 20, width: 20,borderadius: 4,)
          : Icon(color: Colors.white, Icons.add),
      ),
    );
  }

  Widget title() {
    return Flexible(
      child: SizedBox(
        width: 80,
        child:widget.isloading
        ?Customskeleten(height: 9, width: 80, borderadius: 7)
        : Text(
          widget.title??'',
          textAlign: TextAlign.center,
          maxLines: 3,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,

            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget price() {
    return widget.isloading
        ? Customskeleten(height: 10, width: 40, borderadius: 7)
          : Text(
      '₹${widget.price?.toStringAsFixed(1)??0}',
      style: TextStyle(fontWeight: FontWeight.w500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() => _scale = 0.6);
        widget.onTap();
        await Future.delayed(const Duration(milliseconds: 100));
        if (mounted) {
          setState(() => _scale = 1.0);
        }
      },

      child: AnimatedScale(
        scale: _scale,

        duration: const Duration(milliseconds: 450),
        child: SizedBox(
          width: 100,
          height: 160,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cardimage(),
                    const SizedBox(height: 5),
                    title(),
                    price(),
                  ],
                ),
                plusicon(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
