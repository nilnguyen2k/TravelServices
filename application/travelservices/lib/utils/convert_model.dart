import 'package:travelservices/models/area_model.dart';
import 'package:travelservices/models/cart_model.dart';
import 'package:travelservices/models/infor_order_model.dart';
import 'package:travelservices/models/order_model.dart';

class ConvertModel {

  static TicketInforOrder convertToTicketInforOrder(TicketCartResponse model) {
    return TicketInforOrder(
      idTicket: model.idTicket, 
      valueTicket: model.valueTicket ?? 0, 
      typeTicket: model.typeTicket ?? "", 
      amountTicket: model.amountTicket ?? 0, 
      note: model.note ?? ""
    );
  }

  static TicketCartRequest convertToTicketCartRequest(TicketInforOrder model) {
    return TicketCartRequest(
      idTicket: model.idTicket, 
      valueTicket: model.valueTicket, 
      typeTicket: model.typeTicket, 
      amountTicket: model.amountTicket, 
      note: model.note
    );
  }

  static TicketsOrder convertToTicketOrder(TicketCartResponse model) {
    return TicketsOrder(
      idTicket: model.idTicket, 
      valueTicket: model.valueTicket ?? 0, 
      typeTicket: model.typeTicket ?? "", 
      amountTicket: model.amountTicket ?? 0, 
      note: model.note ?? ""
    );
  }

  static AreaData convertToAreaData(AreaFavorite model) {
    return AreaData(
      id: model.idArea, 
      name: model.nameArea, 
      url: model.url
    );
  }


}