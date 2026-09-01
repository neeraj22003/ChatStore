import 'dart:convert';

import 'package:chat_shop/src/core/items/data/ebayitem_dto.dart';
import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';

import 'package:chat_shop/src/core/items/data/search_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersDto {
  final String orderId;
  final String name;
  final String phone;
  final String address;
  final String total;
  final List<SearchDomain> items;
  OrdersDto({
    required this.orderId,
    required this.name,
    required this.phone,
    required this.address,
    required this.total,
    required this.items,
  });
  factory OrdersDto.fromdoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrdersDto(
      orderId: data['orderid']??'',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
      total: data['total'] ?? '',
      items: List.from(data['items']??[]).map((data)=>SearchDto.fromdetaildto(EbuyItemsDetails.fromjson(data), null).toDomain()).toList()
    );
  }
  Map<String, dynamic> toFireJson() {
    return {
      "orderid":orderId,
      'name': name,
      'phone': phone,
      'address': address,
      'items': items.map((data)=>SearchDto(itemId: data.itemId, title: data.title, imageUrl: data.imageUrl,inrprice:data.inrprice,).toJson()).toList(),
      'total': total,
      'createdAT': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toSqJson() {
    return {
      "orderid":orderId,
      'name': name,
      'phone': phone,
      'address': address,
      'items':jsonEncode( items.map((data)=>SearchDto(itemId: data.itemId, title: data.title, imageUrl: data.imageUrl,inrprice:data.inrprice,).toJson()).toList()),
      'total': total,
      'createdAT': DateTime.now().toIso8601String(),
    };
  }
  factory OrdersDto.fromdb(Map<String,dynamic> data) {
   
    return OrdersDto(
      orderId: data['orderid'],
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
      total: data['total'] ?? '',
      items: List.from(jsonDecode(data['items']??[])).map((data)=>SearchDto.fromdetaildto(EbuyItemsDetails.fromjson(data), null).toDomain()).toList()
    );
  }
 Orders toDomain() {
    return Orders(
      orderId: orderId,
      name: name,
      phone: phone,
      address: address,
      total: total,
      items: items,
    );
  }
}
