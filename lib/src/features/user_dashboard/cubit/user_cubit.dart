import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';
import 'package:chat_shop/src/core/user/domain/user_usecases/user_usecase.dart';
import 'package:chat_shop/src/features/user_dashboard/cubit/user_state.dart';

import 'package:chat_shop/src/features/user_dashboard/domain/use_cases/use_cases.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UserDashboardCubit extends Cubit<UserState> {
  final UserUsecase userUsecase;
  final UserdashboardUseCases userdashboardUseCases;
  UserDashboardCubit(this.userUsecase, this.userdashboardUseCases)
    : super(UserState(isloading: true));

  Future<void> getUser() async {
    emit(state.copywith(isloading: true));
   
    final getuser = await userUsecase.getUser();

    final isuserlinked = await userdashboardUseCases.isUserLinked();
   
    if (getuser.isFailure) {
      emit(state.copywith(error: getuser.error, isloading: false));
    }
    if (getuser.isSuccess) {
     
      emit(
        state.copywith(
          userdata: getuser.data,
          islinked: isuserlinked.data,
          isloading: false,
        ),
      );
    }
  }

  Future<void> linkWithGoogle() async {
    emit(state.copywith(isloading: true));

    try {
      final link = await userdashboardUseCases.linkUser();
      final isuserlinked = await userdashboardUseCases.isUserLinked();
      if (link.error == null) {
        await userUsecase.injectProfile.call();
        final userdata = await userUsecase.getUser();
        emit(
          state.copywith(
            islinked: isuserlinked.data,
            userdata: userdata.data,
            isloading: false,
          ),
        );
      } else {
        emit(state.copywith(error: link.error));
      }
    } catch (e) {
      emit(state.copywith(error: e.toString()));
    }
  }

  Future<void> unlink() async {
    emit(state.copywith(isloading: true));

    try {
      await userdashboardUseCases.unlinkUser();
      final isuserlinked = await userdashboardUseCases.isUserLinked();
      final userdata = await userUsecase.getUser();
      emit(
        state.copywith(
          userdata: userdata.data,
          islinked: isuserlinked.data,
          isloading: false,
        ),
      );
    } catch (e) {
      emit(state.copywith(error: e.toString()));
    }
  }
}
