import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/user_dashboard/domain/user_dashboard_repository.dart';

class IsUserLinked {
  final UserDashboardRepository repo;
  IsUserLinked(this.repo);
  Future<Result<bool>> call() async {
    return await repo.isUserlinked();
  }
}
