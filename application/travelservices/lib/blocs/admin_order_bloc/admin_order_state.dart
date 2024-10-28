import 'package:equatable/equatable.dart';
import 'package:travelservices/models/manage_order_model.dart';

class AdminOrderState extends Equatable {

  final List<OrderDataModel> ordersByPending;
  final List<OrderDataModel> ordersByApproved;
  final bool getLoading;

  final bool statusReadPending;
  final bool statusReadApproved;

  final int statusCancel;
  final int statusApproved;
  final int statusExperience;

  const AdminOrderState({
    required this.statusReadPending,
    required this.statusReadApproved,
    required this.ordersByPending,
    required this.ordersByApproved,
    required this.getLoading,
    required this.statusCancel,
    required this.statusApproved,
    required this.statusExperience
  });

  AdminOrderState copyWith({
    List<OrderDataModel>? ordersByPending,
    List<OrderDataModel>? ordersByApproved,
    bool? statusReadPending,
    bool? statusReadApproved,
    bool? getLoading,
    int? statusCancel,
    int? statusApproved,
    int? statusExperience
  }) {
    return AdminOrderState(
      ordersByPending: ordersByPending ?? this.ordersByPending, 
      ordersByApproved: ordersByApproved ?? this.ordersByApproved, 
      getLoading: getLoading ?? this.getLoading, 
      statusCancel: statusCancel ?? this.statusCancel, 
      statusApproved: statusApproved ?? this.statusApproved, 
      statusExperience: statusExperience ?? this.statusExperience, 
      statusReadApproved: statusReadApproved ?? this.statusReadApproved, 
      statusReadPending: statusReadPending ?? this.statusReadPending
    );
  }

  factory AdminOrderState.empty() {
    return const AdminOrderState(
      ordersByPending: <OrderDataModel>[], 
      ordersByApproved: <OrderDataModel>[], 
      getLoading: false, 
      statusCancel: 0, 
      statusApproved: 0, 
      statusExperience: 0, 
      statusReadApproved: false, 
      statusReadPending: false
    );
  }

  @override
  List<Object?> get props => [
    ordersByPending,
    ordersByApproved,
    getLoading,
    statusApproved,
    statusCancel,
    statusExperience,
    statusReadApproved,
    statusReadPending
  ];
}