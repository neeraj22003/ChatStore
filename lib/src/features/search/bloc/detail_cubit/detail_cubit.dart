import 'package:chat_shop/src/core/items/domain/usecases/usecases_bundle/item_use_cases.dart';
import 'package:chat_shop/src/features/search/bloc/detail_cubit/detail_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCubit extends Cubit<DetailState> {
  final ItemUseCases itemUseCases;

  DetailCubit(this.itemUseCases) : super(IsDetailsInitial());

  Future<void> getdetail(String itemid) async {
    emit(IsDetailsLoading());
    try {
      final details = await itemUseCases.getDetails(itemid);

      if (details.data != null) {
        emit(IsDetailsLoded(details.data!));
      } else {
        emit(IsDetailsError(details.error));
      }
    } catch (e) {
      emit(IsDetailsError(e.toString()));
    }
  }

  Future<void> updatequantity(String itemid, int quantity) async {
    try {
      final update = await itemUseCases.updateQuantiy.call(itemid, quantity);
      if (update.error != null) {
        emit(IsDetailsError(update.error));
      } else {}
    } catch (e) {
      emit(IsDetailsError(e.toString()));
    }
  }

  void startloading() {
    emit(IsDetailsLoading());
  }
}
