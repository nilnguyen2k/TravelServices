import 'package:equatable/equatable.dart';
import 'package:travelservices/models/product_details_model.dart';

class ProductDetailsState extends Equatable {

  final bool getLoading;
  final ProductDetailsModel? productDetails;
  

  const ProductDetailsState({
    required this.getLoading,
    this.productDetails,
  });

  factory ProductDetailsState.empty() {
    return const ProductDetailsState(getLoading: false);
  }

  ProductDetailsState copyWith ({bool? getLoading, ProductDetailsModel? productDetails}) {
    return ProductDetailsState(
      getLoading: getLoading ?? this.getLoading,
      productDetails: productDetails ?? this.productDetails,
    );
  }
  
  @override
  List<Object?> get props => [getLoading, productDetails];
}

