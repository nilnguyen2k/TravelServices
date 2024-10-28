import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelservices/models/product_admin_model.dart';
import 'package:travelservices/screens/widgets/dynamic_schedule_widget.dart';
import 'package:travelservices/screens/widgets/dynamic_ticket_widget.dart';

class AdminProductState extends Equatable {
  
  final bool getLoading;
  final bool getProductDetails;

  final int statusDeleteImage;
  
  final List<ProductShow> listProduct;

  final List<XFile> images;
  final int statusUploadImages;

  final ProductDetails? readProduct;

  final List<GalleryDetailsProduct> listImages;

  final CreateProduct? product; 
  final int statusCreate;

  final UpdateProduct? updateProduct; 
  final int statusUpdate;

  final int idCategory;
  final int idArea;
  final int curentIndex;

  final List<DynamicTicketWidget> dynamicTicket;
  final List<DynamicScheduleWidget> dynamicSchedule;

  const AdminProductState({
    required this.statusUpdate,
    required this.updateProduct,
    required this.getLoading,
    required this.images,
    required this.product,
    required this.statusCreate,
    required this.statusUploadImages,
    required this.idArea,
    required this.idCategory,
    required this.curentIndex,
    required this.dynamicTicket,
    required this.dynamicSchedule,
    required this.readProduct,
    required this.getProductDetails,
    required this.statusDeleteImage,
    required this.listProduct,
    required this.listImages
  });

  factory AdminProductState.empty() {
    return const AdminProductState(
      getLoading: false, 
      getProductDetails: false,
      images: <XFile>[],
      statusCreate: 0,
      statusUploadImages: 0,
      idArea: 0,
      idCategory: 0,
      curentIndex: 0,
      dynamicTicket: <DynamicTicketWidget>[],
      dynamicSchedule: <DynamicScheduleWidget>[],
      product: null,
      readProduct: null,
      statusDeleteImage: 0,
      listProduct: <ProductShow>[],
      listImages: <GalleryDetailsProduct>[], 
      statusUpdate: 0, 
      updateProduct: null
    );
  }

  AdminProductState copyWith({
    bool? getLoading,
    List<XFile>? images,
    CreateProduct? product,
    int? statusCreate,
    int? statusUploadImages,
    int? idArea,
    int? idCategory,
    int? curentIndex,
    List<DynamicTicketWidget>? dynamicTicket,
    List<DynamicScheduleWidget>? dynamicSchedule,
    ProductDetails? readProduct,
    bool? getProductDetails,
    int? statusDeleteImage,
    List<ProductShow>? listProduct,
    List<GalleryDetailsProduct>? listImages,
    int? statusUpdate,
    UpdateProduct? updateProduct
  }) {
    return AdminProductState(
      getLoading: getLoading ?? this.getLoading, 
      images: images ?? this.images,
      product: product ?? this.product,
      statusCreate: statusCreate ?? this.statusCreate,
      statusUploadImages: statusUploadImages ?? this.statusUploadImages,
      idArea: idArea ?? this.idArea,
      idCategory: idCategory ?? this.idCategory,
      curentIndex: curentIndex ?? this.curentIndex,
      dynamicTicket: dynamicTicket ?? this.dynamicTicket,
      dynamicSchedule: dynamicSchedule ?? this.dynamicSchedule,
      readProduct: readProduct ?? this.readProduct,
      getProductDetails: getProductDetails ?? this.getProductDetails,
      statusDeleteImage: statusDeleteImage ?? this.statusDeleteImage,
      listProduct: listProduct ?? this.listProduct,
      listImages: listImages ?? this.listImages, 
      statusUpdate: statusUpdate ?? this.statusUpdate, 
      updateProduct: updateProduct ?? this.updateProduct
    );
  }
  
  @override
  List<Object?> get props => [
    getLoading, 
    getProductDetails,
    images, 
    product, 
    statusCreate, 
    statusUploadImages, 
    idCategory, 
    idArea, 
    curentIndex, 
    dynamicTicket,
    dynamicSchedule,
    readProduct,
    listProduct,
    listImages,
    statusUpdate,
    updateProduct
  ];

}