import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/cart/domain/cart_repo.dart';

class GetLocation {
  final CartRepositry repo;
  GetLocation(this.repo);
  Future<Result<String?>> call() async {
    return await repo.getlocation();
  }
}
