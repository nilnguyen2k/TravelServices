import 'package:equatable/equatable.dart';
import 'package:travelservices/models/order_model.dart';

class OrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderSubmitEvent extends OrderEvent {
  final OrderRequestModel orderData;
  OrderSubmitEvent({
    required this.orderData
  });
}

class OrderResetEvent extends OrderEvent {
  OrderResetEvent();
}