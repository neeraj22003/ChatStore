class EbuyItemsModel {
  final String itemId;
  final String title;
  final String imageurl;
  final String price;

  EbuyItemsModel({
    required this.itemId,
    required this.title,
    required this.imageurl,
    required this.price,
  });

  factory EbuyItemsModel.fromJson(Map<String, dynamic> json) {
    return EbuyItemsModel(
      itemId: json['itemId'] ?? '',
      title: json['title'] ?? '',
      imageurl: json['image']?['imageUrl'] ?? '',
      price: json['price']?['value'] ?? '0.00',
    );
  }
}

class EbuyItemsDetails {
  final String itemid;
  final String title;
  final String? imageUrl;
  final String price;
  final String? description;
  final double inrprice;

  int quantity;
  EbuyItemsDetails({
    this.itemid = '',
    this.inrprice = 0.0,
    required this.title,
    required this.imageUrl,

    required this.price,
    required this.description,
    this.quantity = 0,
  });

  Map<String, dynamic> tojson() {
    return {
      'itemId': itemid,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
      'description': description,
    };
  }

  factory EbuyItemsDetails.fromjson(Map<String, dynamic> json) {
    return EbuyItemsDetails(
      itemid: json['itemId'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['image']?['imageUrl'] ?? json['imageUrl'],
      price: json['price']?['value'] ?? '',
      inrprice: json['inrprice'] ?? '',
      description: json['description'] ?? 'no description',
      quantity: json['quantity'] ?? 1,
    );
  }
}
