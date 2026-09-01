import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/core/user/domain/user_usecases/user_usecase.dart';
import 'package:chat_shop/src/features/user_dashboard/cubit/user_state.dart';

import 'package:chat_shop/src/features/user_dashboard/domain/use_cases/use_cases.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UserDashboardCubit extends Cubit<UserDashBoardState> {
  final UserUsecase userUsecase;
  final UserdashboardUseCases userdashboardUseCases;
  UserDomain? _user;
  UserDashboardCubit(this.userUsecase, this.userdashboardUseCases)
    : super(UserDashBoardInitial());

  Future<void> getUser() async {
    emit(UserDashBoardLoading());

    final getuser = await userUsecase.getUser();

    final isuserlinked = await userdashboardUseCases.isUserLinked();

    if (getuser.isFailure) {
      emit(UserDashBoardError(getuser.error));
    }
    if (getuser.isSuccess && getuser.data != null) {
      _user = getuser.data;
      emit(
        UserDashBoardLoaded(user: getuser.data!, islinked: isuserlinked.data!)
      );
    }
  }

  Future<void> linkWithGoogle() async {
    emit(UserDashBoardLoading());

    try {
      final link = await userdashboardUseCases.linkUser();
      final isuserlinked = await userdashboardUseCases.isUserLinked();
      if (link.error == null) {
        await userUsecase.injectProfile.call();
        final userdata = await userUsecase.getUser();
        emit(
         UserDashBoardLoaded(user: userdata.data!, islinked: isuserlinked.data!)
        );
      } else {
        emit(UserDashBoardError(link.error));
      }
    } catch (e) {
      emit(UserDashBoardError(e.toString()));
    }
  }

  Future<void> unlink() async {
    emit(UserDashBoardLoading());

    try {
      await userdashboardUseCases.unlinkUser();
      final isuserlinked = await userdashboardUseCases.isUserLinked();
      final userdata = await userUsecase.getUser();
      emit(
        UserDashBoardLoaded(user: userdata.data!, islinked: isuserlinked.data!)
      );
    } catch (e) {
      emit(UserDashBoardError(e.toString()));
    }
  }

  Future<void> retry() async {
    final isuserlinked = await userdashboardUseCases.isUserLinked();
    emit(
      UserDashBoardLoaded(user: _user!, islinked: isuserlinked.data!)
    );
  }

}
