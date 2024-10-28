import 'package:equatable/equatable.dart';
import 'package:travelservices/models/cart_model.dart';

class CartState extends Equatable {
  
  final bool getLoading;
  final List<CartResponseModel> items;
  final List<bool> itemsChoose;
  final bool statusClick;
  
  final bool statusCreate;

  final bool statusUpdate;

  final bool statusDelete;

  final int statusProccess;

  

  const CartState({
    required this.getLoading,
    required this.items,
    required this.itemsChoose,
    required this.statusCreate,
    required this.statusDelete,
    required this.statusUpdate,
    required this.statusClick,
    required this.statusProccess
  });

  factory CartState.empty() {
    return CartState(
      getLoading: false, 
      items: const <CartResponseModel>[], 
      itemsChoose: List.generate(20, (index) => false),
      statusCreate: false, 
      statusDelete: false, 
      statusUpdate: false,
      statusClick: false,
      statusProccess: 0
    );
  }

  CartState copyWith({
    bool? getLoading,
    List<CartResponseModel>? items,
    List<bool>? itemsChoose,
    bool? statusCreate,
    bool? statusDelete,
    bool? statusUpdate,
    bool? statusClick,
    int? statusProccess
  }) {
    return CartState(
      getLoading: getLoading ?? this.getLoading, 
      items: items ?? this.items,
      itemsChoose: itemsChoose ?? this.itemsChoose, 
      statusCreate: statusCreate ?? this.statusCreate, 
      statusDelete: statusDelete ?? this.statusDelete, 
      statusUpdate: statusUpdate ?? this.statusUpdate,
      statusClick: statusClick ?? this.statusClick,
      statusProccess: statusProccess ?? this.statusProccess
    );
  }

  @override
  List<Object?> get props => [getLoading, items, itemsChoose, statusCreate, statusDelete, statusUpdate, statusClick, statusProccess];

}