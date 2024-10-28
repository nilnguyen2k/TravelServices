import 'package:travelservices/models/infor_order_model.dart';

class InforOrderArgument {
  final int idService;
  final bool status;

  // True is details product, False is change cart
  final bool way;

  final String? dayBook;
  final String? timeBook;
  final List<TicketInforOrder>? tickets;
  

  final String nameProduct;
  final String description;
  final String? url;
  final int? idCartItem;

  InforOrderArgument({
    required this.idService,
    required this.status,
    required this.nameProduct,
    required this.description,
    required this.way,
    this.dayBook,
    this.timeBook,
    this.tickets,
    this.idCartItem,
    this.url
  });
  
}