import 'package:equatable/equatable.dart';
import 'package:travelservices/models/cart_model.dart';

class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartReadEvent extends CartEvent {
  CartReadEvent();
}

class CartResetEvent extends CartEvent {
  CartResetEvent();
}

class CartAddEvent extends CartEvent {
  final CartRequestModel data;
  CartAddEvent({
    required this.data
  });
}

class CartUpdateEvent extends CartEvent {
  final int idCartItem;
  final CartRequestModel data;
  CartUpdateEvent({
    required this.idCartItem,
    required this.data
  });
}

class CartDeleteEvent extends CartEvent {
  final int idCartItem;
  CartDeleteEvent({
    required this.idCartItem
  });
}

class CartChooseItemEvent extends CartEvent {
  final int index;
  final bool? status;
  CartChooseItemEvent({
    required this.index,
    required this.status
  }); 
}



