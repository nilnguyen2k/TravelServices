import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/product_details_bloc/product_details_event.dart';
import 'package:travelservices/blocs/product_details_bloc/product_details_state.dart';
import 'package:travelservices/models/product_details_model.dart';
import 'package:travelservices/repositories/product_repositories.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductRepository productRepository = ProductRepository();
  ProductDetailsBloc() : super(ProductDetailsState.empty()) {
    on<ProductDetailsLoadEvent>(_onLoadEvent);
    on<ProductDetailsReadEvent>(_onReadEvent);
  }

  void _onLoadEvent(ProductDetailsLoadEvent event, Emitter<ProductDetailsState> emit) async {
    emit(state.copyWith(getLoading: true));

    ProductDetailsModel data = await productRepository.getProductDetails("public/serviceDetails?idService=${event.id}");

    emit(state.copyWith(productDetails: data, getLoading: false));

  }

  void _onReadEvent(ProductDetailsReadEvent event, Emitter<ProductDetailsState> emit) {
    emit(state.copyWith(productDetails: event.productDetails));
  }
}