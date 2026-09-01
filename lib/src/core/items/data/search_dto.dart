import 'package:chat_shop/src/core/items/data/ebayitem_dto.dart';
import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';

class SearchDto {
  final String itemId;
  final String title;
  final String imageUrl;
  final double? price;
  int quantity;
  final String? description;
  final double? inrprice;
  SearchDto({
    required this.itemId,
    required this.title,
    required this.imageUrl,
    this.price=0,
    this.quantity = 1,
    this.description,
    this.inrprice,
  });

  factory SearchDto.fromListdto(EbuyItemsModel dto, double inrrate) {
    return SearchDto(
      itemId: dto.itemId,
      title: dto.title,
      imageUrl: dto.imageurl,
      price: double.tryParse(dto.price) ?? 0.0,
      inrprice: (double.tryParse(dto.price) ?? 0.0) * inrrate,
    );
  }
  factory SearchDto.fromdetaildto(EbuyItemsDetails dto, double? inrrate) {
    return SearchDto(
      itemId: dto.itemid,
      title: dto.title,
      imageUrl: dto.imageUrl ?? '',
      price: double.tryParse(dto.price) ?? 0.0,
      quantity: dto.quantity,
      inrprice: inrrate == null
          ? dto.inrprice
          : (double.tryParse(dto.price) ?? 0.0) * inrrate,
      description: dto.description ??''  
    );
    
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'title': title,
      'imageUrl': imageUrl,

      'quantity': quantity,

      'inrprice': inrprice,
      'shortDescription': description,
    };
  }

  SearchDomain toDomain() {
    return SearchDomain(
      itemId: itemId,
      title: title,
      imageUrl: imageUrl,
      price: price!,
      quantity: quantity,
      description: description,
      inrprice: inrprice
    );
  }
}
