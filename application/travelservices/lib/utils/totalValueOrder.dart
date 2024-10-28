import 'package:travelservices/models/infor_order_model.dart';

class TotalValueOrder {
  static int totalValue (List<TicketInforOrder> tickets, List<int> quatity) {
    int total = 0;
    for (int i = 0; i < tickets.length; i++) {
      total = total + quatity[i]*tickets[i].valueTicket;
    }
    return total;
  }
}