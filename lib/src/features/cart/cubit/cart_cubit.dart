import 'package:chat_shop/src/core/items/domain/usecases/usecases_bundle/item_use_cases.dart';
import 'package:chat_shop/src/core/result/result_domain.dart';

import 'package:chat_shop/src/core/user/domain/user_usecases/user_usecase.dart';
import 'package:chat_shop/src/features/cart/cubit/cart_state.dart';

import 'package:chat_shop/src/core/items/domain/search_item_domain.dart';
import 'package:chat_shop/src/features/cart/domain/cart_usecases.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final ItemUseCases itemUseCases;
  
  final CartUsecases cartUsecases;
  CartCubit(this.itemUseCases, this.cartUsecases)
    : super(Cartinitial());

  Future<void> additemToCart(SearchDomain item) async {
    emit(Cartloading());
    try {
      await itemUseCases.saveItem.call(item);
      final cartitem = itemUseCases.getCartlist.call();
      
      final totalcost = itemUseCases.getTotalCost.call();

      emit(Cartloaded(cartitem, totalcost));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void loaditem(Result<List<SearchDomain>?> items) async {
    try {
      if (items.data == null || items.data!.isEmpty) {
        emit(Cartinitial());
      } else if (items.error != null) {
        emit(CartError(items.error));
      } else {
        
        final totalcost = itemUseCases.getTotalCost.call();
        emit(Cartloaded(items.data!, totalcost));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  int getcurrentItemlength() {
    return itemUseCases.getCartlist.call().length;
  }

  double totalcost() => itemUseCases.getTotalCost.call();

  Future<void> onIncrement(SearchDomain item) async {
    try {
      item.quantitynotfier.value++;
      final update = await itemUseCases.updateQuantiy.call(
        item.itemId,
        item.quantitynotfier.value,
      );

      if (update.error != null) {
        emit(CartError(update.error));
      } else {}
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> onDecrement(SearchDomain item) async {
    try {
      if (item.quantitynotfier.value > 1) {
        item.quantitynotfier.value--;
        await itemUseCases.updateQuantiy.call(
          item.itemId,
          item.quantitynotfier.value,
        );
      } else {
        item.quantitynotfier.value--;

        await itemUseCases.deleteItem.call(item.itemId);
        final bool = itemUseCases.getCartlist.call().isEmpty;
        if (bool) {
          emit(Cartinitial());
        }
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<String?> getlocation(
    String? value,
    ValueNotifier<bool> isloading,
    ValueNotifier<String?> currentlocation,
  ) async {
    try {
      if (value == null || value.isEmpty) {
        isloading.value = true;
        final location = await cartUsecases.getLocation.call();

        if (location.error != null) {
          emit(CartError(location.error));
        } else {
          await Future.delayed(const Duration(seconds: 1));
          currentlocation.value = location.data;
          isloading.value = false;
          return location.data ?? '';
        }
      } else {
        isloading.value = false;
        return value;
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
    return value;
  }

  Future<void> clearCart() async {
    final result = await itemUseCases.clearCart.call();
    if (result.isFailure) {
      emit(CartError(result.error));
    }

    if (result.isSuccess) {
    
        emit(Cartinitial());
      
      
    }
  }
}
