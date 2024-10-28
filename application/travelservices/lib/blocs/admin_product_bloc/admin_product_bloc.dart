import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_event.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_state.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/product_admin_model.dart';
import 'package:travelservices/repositories/product_repositories.dart';
import 'package:travelservices/screens/widgets/dynamic_schedule_widget.dart';
import 'package:travelservices/screens/widgets/dynamic_ticket_widget.dart';

class AdminProductBloc extends Bloc<AdminProductEvent, AdminProductState> {
  ProductRepository productRepo = ProductRepository();
  AdminProductBloc() : super(AdminProductState.empty()) {

    on<AdminResetStateProductEvent>(onResetStateProduct);

    on<AdminReadListProductEvent>(onReadListProduct);

    on<AdminAddProductEvent>(onAddProduct);
    on<AdminUpdateProductEvent>(onUpdateProduct);
    on<AdminProductDetailsEvent>(onProductDetails);

    on<AdminCurrentIndexProductEvent>(onCurrentIndexProduct);
    on<AdminIdAreaEvent>(onIdAreaProduct);
    on<AdminIdCategoryEvent>(onIdCategoryProduct);
    
    on<AdminSelectMultipleImageEvent>(onSelectImages);
    on<AdminUnSelectMultipleImageEvent>(onUnSelectImages);

    on<AdminAddDynamicTicketProductEvent>(onAddDynamicTicketProduct);
    on<AdminDeleteDynamicTicketProductEvent>(onDeleteDynamicTicketProduct);
    
    on<AdminAddDynamicScheduleProductEvent>(onAddDynamicScheduleProduct);
    on<AdminDeleteDynamicScheduleProductEvent>(onDeleteDynamicScheduleProduct);

    on<AdminDeleteImageProductEvent>(onDeleteImageProduct);
  }

  void onAddProduct(AdminAddProductEvent event, Emitter<AdminProductState> emit) async {
    var data = await productRepo.postServiceForAdmin(event.product);
    if (data.message.isEmpty) {
      print("Thêm thất bại");
      emit(state.copyWith(statusCreate: -1));
    } else {
      print("Thêm thành công");
      emit(state.copyWith(statusCreate: 1));
    }
    emit(state.copyWith(statusCreate: 0));
  }

  void onUpdateProduct(AdminUpdateProductEvent event, Emitter<AdminProductState> emit) async {
    var data = await productRepo.putServiceForAdmin(event.product, event.idService);
    if (data.message.isEmpty) {
      print("Sửa thất bại");
      emit(state.copyWith(statusUpdate: -1));
    } else {
      print("Sửa thành công");
      emit(state.copyWith(statusUpdate: 1));
    }
    emit(state.copyWith(statusUpdate: 0));
  }

  void onProductDetails(AdminProductDetailsEvent event, Emitter<AdminProductState> emit) async {
    emit(state.copyWith(getLoading: true));
    var data = await productRepo.getProductDetailsForAdmin("admin/serviceDetails?idService=${event.idService}");
    emit(state.copyWith(readProduct: data, getLoading: false, getProductDetails: true, listImages: data.galleries));
    emit(state.copyWith(getProductDetails: false));
  }

  
  // Untils
  void onIdAreaProduct(AdminIdAreaEvent event, Emitter<AdminProductState> emit) {
    emit(state.copyWith(idArea: event.idArea));
  }

  void onIdCategoryProduct(AdminIdCategoryEvent event, Emitter<AdminProductState> emit) {
    emit(state.copyWith(idCategory: event.idCategory));
  }

  void onCurrentIndexProduct(AdminCurrentIndexProductEvent event, Emitter<AdminProductState> emit) {
    emit(state.copyWith(curentIndex: event.currentIndex));
  }

  // Image
  void onUnSelectImages(AdminUnSelectMultipleImageEvent event, Emitter<AdminProductState> emit) {
    
  }

  void onSelectImages(AdminSelectMultipleImageEvent event, Emitter<AdminProductState> emit) {
    emit(state.copyWith(images: event.images));
  }

  // Dynamic widget
  void onAddDynamicTicketProduct(AdminAddDynamicTicketProductEvent event, Emitter<AdminProductState> emit) {
    List<DynamicTicketWidget> temp = state.dynamicTicket.toList();
    temp.add(DynamicTicketWidget());
    emit(state.copyWith(dynamicTicket: temp));
  }

  void onAddDynamicScheduleProduct(AdminAddDynamicScheduleProductEvent event, Emitter<AdminProductState> emit) {
    List<DynamicScheduleWidget> temp = state.dynamicSchedule.toList();
    temp.add(DynamicScheduleWidget());
    emit(state.copyWith(dynamicSchedule: temp));
  }

  void onDeleteDynamicScheduleProduct(AdminDeleteDynamicScheduleProductEvent event, Emitter<AdminProductState> emit) {
    List<DynamicScheduleWidget> temp = state.dynamicSchedule.toList();
    temp.removeAt(event.index);
    emit(state.copyWith(dynamicSchedule: temp));
  }

  void onDeleteDynamicTicketProduct(AdminDeleteDynamicTicketProductEvent event, Emitter<AdminProductState> emit) {
    List<DynamicTicketWidget> temp = state.dynamicTicket.toList();
    temp.removeAt(event.index);
    emit(state.copyWith(dynamicTicket: temp));
  }

  void onDeleteImageProduct(AdminDeleteImageProductEvent event, Emitter<AdminProductState> emit) async {
    var data = await productRepo.deleteImageProduct("admin/delete/", event.idLink.toString(), event.publicId, state.readProduct!.service.id.toString());
    if (data is MessageModel) {
      if (data.message == "Error 403") {
        emit(state.copyWith(statusDeleteImage: -1));
      }   
    } 
    if (data is List<GalleryDetailsProduct>) {
      emit(state.copyWith(listImages: data, statusDeleteImage: 1));
    }
    emit(state.copyWith(statusDeleteImage: 0));
  }

  void onReadListProduct(AdminReadListProductEvent event, Emitter<AdminProductState> emit) async {
    emit(state.copyWith(getLoading: true));
    var data = await productRepo.getListProductForAdmin("admin/service");
    emit(state.copyWith(getLoading: false, listProduct: data));
  }

  void onResetStateProduct(AdminResetStateProductEvent event, Emitter<AdminProductState> emit) {
    emit(state.copyWith(
      getLoading: false, 
      getProductDetails: false,
      images: <XFile>[],
      statusCreate: 0,
      statusUploadImages: 0,
      curentIndex: 0,
      dynamicTicket: <DynamicTicketWidget>[],
      dynamicSchedule: <DynamicScheduleWidget>[],
      product: null,
      readProduct: null,
      statusDeleteImage: 0,
      listImages: <GalleryDetailsProduct>[], 
      statusUpdate: 0, 
      updateProduct: null
    ));
  }
}