import 'package:chat_shop/src/features/cart/data/cart_repo_impl.dart';
import 'package:chat_shop/src/features/cart/domain/get_location.dart';

class CartUsecases {
  final GetLocation getLocation;
  CartUsecases(CartRepoImpl repo) : getLocation = GetLocation(repo);
}
