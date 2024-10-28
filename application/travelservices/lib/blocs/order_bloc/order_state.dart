import 'package:equatable/equatable.dart';
import 'package:travelservices/models/order_model.dart';

class OrderState extends Equatable {
  
  final bool? getLoading;
  final int? statusOrder;
  final OrderRequestModel? orderData;

  const OrderState({
    required this.getLoading,
    required this.statusOrder,
    required this.orderData
  });

  factory OrderState.empty() {
    return const OrderState(
      getLoading: false,
      statusOrder: 0, 
      orderData: null
    );
  }

  OrderState copyWith({
    bool? getLoading,
    int? statusOrder,
    OrderRequestModel? orderData
  }) {
    return OrderState(
      getLoading: getLoading ?? this.getLoading,
      statusOrder: statusOrder ?? this.statusOrder, 
      orderData: orderData ?? this.orderData
    );
  }
  
  @override
  List<Object?> get props => [getLoading, orderData, statusOrder];

}