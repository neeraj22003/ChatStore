import 'package:chat_shop/src/features/search/domain/category_domain.dart';
import 'package:flutter/material.dart';

class EbayCategory {
  static List<CategoryDomain> get list => [
    CategoryDomain(id: '293', name: 'Electronics', icon: Icons.devices),
    CategoryDomain(id: '11450', name: 'Fashion', icon: Icons.checkroom),
    CategoryDomain(id: '15032', name: 'Toys', icon: Icons.toys),
    CategoryDomain(id: '11700', name: 'Home & Garden', icon: Icons.home),
    CategoryDomain(id: '1', name: 'Collectibles', icon: Icons.star),
    CategoryDomain(id: '6000', name: 'Motors', icon: Icons.directions_car),
    CategoryDomain(id: '888', name: 'Sporting Goods', icon: Icons.sports_soccer),
    CategoryDomain(id: '26395', name: 'Health & Beauty', icon: Icons.health_and_safety),
    CategoryDomain(id: '12576', name: 'Business & Industrial', icon: Icons.business),
    CategoryDomain(id: '267', name: 'Books', icon: Icons.book),
    CategoryDomain(id: '11233', name: 'Music', icon: Icons.music_note),
    CategoryDomain(id: '619', name: 'Art', icon: Icons.brush),
    CategoryDomain(id: '870', name: 'Cameras & Photo', icon: Icons.camera_alt),
    CategoryDomain(id: '11116', name: 'Cell Phones & Accessories', icon: Icons.smartphone),
    CategoryDomain(id: '281', name: 'Jewelry & Watches', icon: Icons.watch),
  ];
}
