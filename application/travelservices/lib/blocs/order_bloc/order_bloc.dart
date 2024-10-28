import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/order_bloc/order_event.dart';
import 'package:travelservices/blocs/order_bloc/order_state.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/order_model.dart';
import 'package:travelservices/repositories/order_repositories.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {

  OrderRepository orderRepository = OrderRepository();

  OrderBloc() : super (OrderState.empty()) {
    on<OrderSubmitEvent>(orderSubmit);
    on<OrderResetEvent>(orderReset);
  }

  void orderSubmit(OrderSubmitEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(getLoading: true));
    var data = await orderRepository.createOrder(event.orderData);
    
    if (data is MessageModel) {
      print("that bai");
      emit(state.copyWith(getLoading: false, statusOrder: -1));
    }

    if (data is OrderResponseModel) {
      print("thanh cong");
      emit(state.copyWith(getLoading: false, statusOrder: 1));
    }

    emit(state.copyWith(getLoading: false, statusOrder: 0));

  }

  void orderReset(OrderResetEvent event, Emitter<OrderState> emit) {
    
  }
}