import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';

abstract class DetailState {}

class IsDetailsInitial extends DetailState {}

class IsDetailsLoading extends DetailState {}

class IsDetailsLoded extends DetailState {
  final SearchDomain details;
  IsDetailsLoded(this.details);
}

class IsDetailsError extends DetailState {
  final String? error;
  IsDetailsError(this.error);
}
