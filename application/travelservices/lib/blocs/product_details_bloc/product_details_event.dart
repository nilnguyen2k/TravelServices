import 'package:equatable/equatable.dart';
import 'package:travelservices/models/product_details_model.dart';

class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();
  @override
  List<Object?> get props => [];
}

class ProductDetailsLoadEvent extends ProductDetailsEvent {
  final int id;
  const ProductDetailsLoadEvent({
    required this.id
  });
}

class ProductDetailsReadEvent extends ProductDetailsEvent {
  final ProductDetailsModel productDetails;
  const ProductDetailsReadEvent({
    required this.productDetails
  });
}