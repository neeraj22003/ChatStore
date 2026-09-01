import 'package:chat_shop/src/features/user_dashboard/domain/use_cases/is_user_linked.dart';
import 'package:chat_shop/src/features/user_dashboard/domain/use_cases/link_user.dart';
import 'package:chat_shop/src/features/user_dashboard/domain/use_cases/unlink_user.dart';
import 'package:chat_shop/src/features/user_dashboard/domain/user_dashboard_repository.dart';

class UserdashboardUseCases {
  final LinkUser linkUser;
  final UnlinkUser unlinkUser;
  final IsUserLinked isUserLinked;
  UserdashboardUseCases(UserDashboardRepository repo)
    : linkUser = LinkUser(repo),
      unlinkUser = UnlinkUser(repo),
      isUserLinked = IsUserLinked(repo);
}
