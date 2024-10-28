import 'package:equatable/equatable.dart';

class AdminOrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminOrderReadByPendingEvent extends AdminOrderEvent {
  AdminOrderReadByPendingEvent();
}

class AdminOrderReadByApprovedEvent extends AdminOrderEvent {
  AdminOrderReadByApprovedEvent();
}

class AdminOrderApprovedEvent extends AdminOrderEvent {
  final int idOrderItem;
  final String status;
  AdminOrderApprovedEvent({
    required this.idOrderItem,
    required this.status,
  });
}

class AdminOrderCancelEvent extends AdminOrderEvent {
  final int idOrderItem;
  final String status;
  AdminOrderCancelEvent({
    required this.idOrderItem,
    required this.status,
  });
}

class AdminOrderExperienceEvent extends AdminOrderEvent {
  final int idOrderItem;
  final String status;
  AdminOrderExperienceEvent({
    required this.idOrderItem,
    required this.status
  });
}