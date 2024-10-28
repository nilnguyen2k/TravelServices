import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/blocs/cart_bloc/cart_event.dart';
import 'package:travelservices/blocs/cart_bloc/cart_state.dart';
import 'package:travelservices/models/cart_model.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/repositories/cart_repositories.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  CartRepository cartRepo = CartRepository();

  CartBloc() : super(CartState.empty()) {
    on<CartReadEvent>(onCartRead);
    on<CartAddEvent>(onCartAdd);
    on<CartUpdateEvent>(onCartUpdate);
    on<CartDeleteEvent>(onCartDelete);
    on<CartChooseItemEvent>(onCartChooseItems);
    on<CartResetEvent>(onCartResetItems);
  }

  void onCartRead(CartReadEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(getLoading: true));
    var data = await cartRepo.getCart("cart?page=1&limit=99&sort=DESC");
    emit(state.copyWith(items: data, getLoading: false));
  }

  void onCartAdd(CartAddEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(statusCreate: true));
    var data = await cartRepo.createCart(event.data);

    if (data is CartResponseModel) {
      emit(state.copyWith(statusProccess: 1, statusCreate: false));
      add(CartReadEvent());
      emit(state.copyWith(statusProccess: 0));
    }

    if (data is MessageModel) {
      emit(state.copyWith(statusProccess: -1, statusCreate: false));
      emit(state.copyWith(statusProccess: 0));
    }

  }

  void onCartUpdate(CartUpdateEvent event, Emitter<CartState> emit) async {
    
    emit(state.copyWith(statusUpdate: true));
    var data = await cartRepo.updateCart(event.data, event.idCartItem);

    if (data is CartResponseModel) {
      emit(state.copyWith(statusProccess: 1, statusUpdate: false));
      add(CartReadEvent());
      print("Update success");
    }

    if (data is MessageModel) {
      emit(state.copyWith(statusProccess: -1, statusUpdate: false));
      print("Update failed");
    }
  }

  void onCartDelete(CartDeleteEvent event, Emitter<CartState> emit) async {
    Api api = Api();
    await api.deleteCartItem(Api.url, "cart/", event.idCartItem.toString());
    add(CartReadEvent());
  }

  void onCartChooseItems(CartChooseItemEvent event, Emitter<CartState> emit) {
    emit(state.copyWith(statusClick: true));
    List<bool> list = state.itemsChoose;
    list[event.index] = event.status!;
    emit(state.copyWith(itemsChoose: list, statusClick: false));
  }

  void onCartResetItems(CartResetEvent event, Emitter<CartState> emit) {
    emit(state.copyWith(
      getLoading: false, 
      items: const <CartResponseModel>[], 
      itemsChoose: List.generate(20, (index) => false),
      statusCreate: false, 
      statusDelete: false, 
      statusUpdate: false,
      statusClick: false,
      statusProccess: 0
    ));
  }
}