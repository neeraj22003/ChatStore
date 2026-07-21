import 'package:flutter/foundation.dart';

class SearchDomain {
  final String itemId;
  final String title;
  final String imageUrl;
  final double price;
  int quantity;
  final String? description;
  final double? inrprice;
  
 
  ValueNotifier<int> quantitynotfier;
  SearchDomain({
    required this.itemId,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.quantity = 0,
    this.description,
    this.inrprice,
 
  }) :
       quantitynotfier = ValueNotifier(quantity);
}
