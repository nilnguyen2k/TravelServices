class OrderRequestModel {

  final InforUserOrder infor;
  final bool? statusOrder;
  final List<ItemsTicket> items;

  OrderRequestModel({
    required this.infor,
    required this.statusOrder,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
    "infor": infor.toJson(),
    "statusOrder": statusOrder,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };

}

class OrderResponseModel {

  final int idOrder;
  final InforUserOrder infor;
  final List<ItemsTicket> items;

  OrderResponseModel({
    required this.idOrder,
    required this.infor,
    required this.items,
  });


  factory OrderResponseModel.fromJson(Map<String, dynamic> json) => OrderResponseModel(
    idOrder: json["idOrder"],
    infor: InforUserOrder.fromJson(json["infor"]),
    items: List<ItemsTicket>.from(json["items"].map((x) => ItemsTicket.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "infor": infor.toJson(),
    "idOrder": idOrder,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };

}

class InforUserOrder {
  
  final String fullname;
  final String email;
  final String phone;
  
  InforUserOrder({
    required this.fullname,
    required this.email,
    required this.phone,
  });

  factory InforUserOrder.fromJson(Map<String, dynamic> json) => InforUserOrder(
    fullname: json["fullname"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "email": email,
    "phone": phone,
  };

}

class ItemsTicket {

  int? idCartItem;
  int idService;
  String bookDay;
  String bookTime;
  String? note;
  String? name;
  String? description;
  String? url;
  List<TicketsOrder> tickets;
  
  ItemsTicket({
    required this.idCartItem,
    required this.idService,
    required this.bookDay,
    required this.bookTime,
    required this.note,
    required this.tickets,
    required this.name,
    required this.description,
    required this.url
  });

  factory ItemsTicket.fromJson(Map<String, dynamic> json) => ItemsTicket(
    idCartItem: json["idCartItem"],
    idService: json["idService"],
    bookDay: json["bookDay"],
    bookTime: json["bookTime"],
    note: json["note"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    url: json["url"] ?? "",
    tickets: List<TicketsOrder>.from(json["tickets"].map((x) => TicketsOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "idCartItem": idCartItem,
    "idService": idService,
    "bookDay": bookDay,
    "bookTime": bookTime,
    "name": name,
    "description": description,
    "url": url,
    "note": note,
    "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
  };

}

class TicketsOrder {
    
  int idTicket;
  int valueTicket;
  String typeTicket;
  int amountTicket;
  String note;

  TicketsOrder({
    required this.idTicket,
    required this.valueTicket,
    required this.typeTicket,
    required this.amountTicket,
    required this.note,
  });

  factory TicketsOrder.fromJson(Map<String, dynamic> json) => TicketsOrder(
    idTicket: json["idTicket"],
    valueTicket: json["valueTicket"],
    typeTicket: json["typeTicket"],
    amountTicket: json["amountTicket"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "idTicket": idTicket,
    "valueTicket": valueTicket,
    "typeTicket": typeTicket,
    "amountTicket": amountTicket,
    "note": note,
  };
}
