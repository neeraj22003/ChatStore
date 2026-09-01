import 'package:chat_shop/src/core/result/result_domain.dart';

abstract class UserDashboardRepository {
  Future<Result<void>> linkwithhgoogle();
  Future<Result<void>> unlink();
  Future<Result<bool>> isUserlinked();
}
