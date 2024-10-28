class CartRequestModel {

  final int idService;
  final String? name;
  final String? url;
  final String? description;
  final String? bookDay;
  final String? bookTime;
  final List<TicketCartRequest> tickets;

  CartRequestModel({
    required this.idService,
    required this.name,
    required this.url,
    required this.description,
    required this.bookDay,
    required this.bookTime,
    required this.tickets,
  });

  Map<String, dynamic> toJson() => {
    "idService": idService,
    "bookDay": bookDay ?? "",
    "bookTime": bookTime ?? "",
    "name": name ?? "",
    "url": url ?? "",
    "description": description ?? "",
    "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
  };

}

class CartResponseModel {
  
  final int idCartItem;
  final int idService;
  final String? name;
  final String? url;
  final String? description;
  final String? bookDay;
  final String? bookTime;
  final List<TicketCartResponse> tickets;

  CartResponseModel({
    required this.idCartItem,
    required this.idService,
    required this.name,
    required this.url,
    required this.description,
    required this.bookDay,
    required this.bookTime,
    required this.tickets,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) => CartResponseModel(
    idCartItem: json["idCartItem"],
    idService: json["idService"],
    bookDay: json["bookDay"] ?? "",
    bookTime: json["bookTime"] ?? "",
    name: json["name"] ?? "",
    url: json["url"] ?? "",
    description: json["description"] ?? "",
    tickets: List<TicketCartResponse>.from(json["tickets"].map((x) => TicketCartResponse.fromJson(x))),
  );
}

class TicketCartResponse {
    
  final int idTicket;
  final int? valueTicket;
  final String? typeTicket;
  final int? amountTicket;
  final String? note;

  TicketCartResponse({
    required this.idTicket,
    required this.valueTicket,
    required this.typeTicket,
    required this.amountTicket,
    required this.note,
  });

  factory TicketCartResponse.fromJson(Map<String, dynamic> json) => TicketCartResponse(
    idTicket: json["idTicket"],
    valueTicket: json["valueTicket"] ?? 0,
    typeTicket: json["typeTicket"] ?? "",
    amountTicket: json["amountTicket"] ?? 0,
    note: json["note"] ?? "",
  );

}

class TicketCartRequest {
  
  final int idTicket;
  final int? valueTicket;
  final String? typeTicket;
  final int? amountTicket;
  final String? note;

  TicketCartRequest({
    required this.idTicket,
    required this.amountTicket,
    required this.valueTicket,
    required this.typeTicket,
    required this.note
  });

  Map<String, dynamic> toJson() => {
    "idTicket": idTicket,
    "amountTicket": amountTicket ?? 0,
    "valueTicket": valueTicket ?? 0,
    "typeTicket": typeTicket ?? "",
    "note": note ?? "",
  };

}
