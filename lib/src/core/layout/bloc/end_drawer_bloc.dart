import 'package:chat_shop/src/core/items/domain/usecases/usecases_bundle/item_use_cases.dart';
import 'package:chat_shop/src/core/layout/bloc/end_drawer_events.dart';
import 'package:chat_shop/src/core/layout/bloc/end_drawer_state.dart';
import 'package:chat_shop/src/core/user/domain/user_usecases/user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EndDrawerBloc extends Bloc<EndDrawerEvents, EndDrawerState> {
  final ItemUseCases itemUseCases;
  final UserUsecase userUsecase;
  EndDrawerBloc(this.itemUseCases, this.userUsecase) : super(Endrawerclosed()) {
    on<OnTapAccountDasboard>((event, emit) {
      emit(IsAcountDasboard());
      Future.microtask(() {
        event.scaffoldkey.currentState!.openEndDrawer();
      });
    });

    on<OnTapCart>((event, emit)async {
      final length = itemUseCases.getCartlist().length;
      final user = await userUsecase.getUser.call();
      emit(IsCart(length,user.data!));

      Future.microtask(() {
        event.scaffoldkey.currentState!.openEndDrawer();
      });
    });
  }
}
