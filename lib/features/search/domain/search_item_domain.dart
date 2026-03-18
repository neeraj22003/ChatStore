import 'package:flutter_experiments/features/search/data/search_dto.dart';

class SearchDomain {
  final String itemId;
  final String title;
  final String imageUrl;
  final double price;
  int quantity;
  final String? description;
  final double? inrprice;
  SearchDomain({
    required this.itemId,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
    this.description,
    this.inrprice,
  });

  factory SearchDomain.fromListdto(EbuyItemsModel dto, double inrrate) {
    return SearchDomain(
      itemId: dto.itemId,
      title: dto.title,
      imageUrl: dto.imageurl,
      price: double.tryParse(dto.price) ?? 0.0,
      inrprice: (double.tryParse(dto.price) ?? 0.0) * inrrate,
    );
  }
  factory SearchDomain.fromdetaildto(EbuyItemsDetails dto, double? inrrate) {
    return SearchDomain(
      itemId: dto.itemid,
      title: dto.title,
      imageUrl: dto.imageUrl ?? '',
      price: double.tryParse(dto.price) ?? 0.0,
      description: dto.description,
      quantity: dto.quantity,
      inrprice: inrrate == null
          ? dto.inrprice
          : (double.tryParse(dto.price) ?? 0.0) * inrrate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,

      'quantity': quantity,

      'inrprice': inrprice,
    };
  }
}
