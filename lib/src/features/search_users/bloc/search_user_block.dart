import 'package:chat_shop/src/core/user/domain/user_usecases/user_usecase.dart';
import 'package:chat_shop/src/features/search_users/data/search_user_repo.dart';

import 'package:chat_shop/src/features/search_users/bloc/search_user_event.dart';
import 'package:chat_shop/src/features/search_users/bloc/search_user_state.dart';
import 'package:chat_shop/src/features/search_users/domain/use_cases/use_case_bundle/use_case_bundle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final SearchuserUseCase searchuserUseCase;
  final UserUsecase userUsecase;
  SearchUserBloc(this.searchuserUseCase, this.userUsecase)
    : super(SearchUserInitial()) {
    on<SearchUser>((event, emit) async {
      if (event.query.isEmpty) return;
      emit(SearchUserLoading());

      final result = await searchuserUseCase.searchUser.call(
        event.query.trim(),
      );
      if (result.isFailure) {
        emit(SearchUserError(result.error));
      }
      if (result.isSuccess) {
        final currentuser = await userUsecase.getUser.call();

        emit(SearchUserLoaded(result.data!, currentuser.data!));
      }
    });

    on<ClearField>((event, emit) {
      event.controller.clear();
      emit(SearchUserInitial());
    });
  }
}
