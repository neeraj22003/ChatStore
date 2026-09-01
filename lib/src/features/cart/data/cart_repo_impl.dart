import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/cart/data/location_service.dart';
import 'package:chat_shop/src/features/cart/domain/cart_repo.dart';

class CartRepoImpl implements CartRepositry {
  final LocationService service;
  CartRepoImpl(this.service);

  @override
  Future<Result<String?>> getlocation() async {
    final location = await service.location();
    if(location.isFailure){
     return  Result.onfailure(location.error);
    }
    final decoder = await service.locationDecoder(location.data!);
    if (decoder.isFailure) {
    
      return Result.onfailure(decoder.error);
    }
    return Result.onSuccess(decoder.data);
  }
}
