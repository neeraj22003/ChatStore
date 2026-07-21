import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/cart/data/location_service.dart';
import 'package:chat_shop/src/features/cart/domain/cart_repo.dart';

class CartRepoImpl implements CartRepositry {
  final LocationService service;
  CartRepoImpl(this.service);

  @override
  Future<Result<String?>> getlocation() async {
    return await service.fetcher();
  }
}
