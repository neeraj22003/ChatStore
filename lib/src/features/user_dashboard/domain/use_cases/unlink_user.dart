import 'package:chat_shop/src/core/result/result_domain.dart';
import 'package:chat_shop/src/features/user_dashboard/domain/user_dashboard_repository.dart';

class UnlinkUser {
  final UserDashboardRepository repo;
  UnlinkUser(this.repo);
  Future<Result<void>> call() async {
    return await repo.unlink();
  }
}
