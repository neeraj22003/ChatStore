import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CartState {}

class Cartinitial extends CartState {}

class Cartloading extends CartState {}

class Cartloaded extends CartState {
  final List<SearchDomain> item;

  final double totalcost;

  Cartloaded(this.item, this.totalcost,);
}

class CartError extends CartState {
  final String? error;
  CartError(this.error);
}

enum LocationType { gps, home, none }
