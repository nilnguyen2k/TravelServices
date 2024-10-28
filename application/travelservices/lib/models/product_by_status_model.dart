class ProductByStatusModel {

  final int id;
  final int idOrder;
  final int idService;
  final String nameService;
  final String description;
  final String url;
  final String bookDay;
  final String bookTime;
  final int total;
  final List<TicketProductByStatus> tickets;
  final InforProductByStatus infor;
  final DateTime createDate;
  final DateTime modifiedDate;

  ProductByStatusModel({
    required this.id,
    required this.idOrder,
    required this.idService,
    required this.nameService,
    required this.description,
    required this.url,
    required this.bookDay,
    required this.bookTime,
    required this.total,
    required this.tickets,
    required this.infor,
    required this.createDate,
    required this.modifiedDate,
  });


  factory ProductByStatusModel.fromJson(Map<String, dynamic> json) => ProductByStatusModel(
    id: json["id"],
    idOrder: json["idOrder"],
    idService: json["idService"],
    nameService: json["nameService"],
    description: json["description"],
    url: json["url"],
    bookDay: json["bookDay"],
    bookTime: json["bookTime"],
    total: json["total"],
    tickets: List<TicketProductByStatus>.from(json["tickets"].map((x) => TicketProductByStatus.fromJson(x))),
    infor: InforProductByStatus.fromJson(json["infor"]),
    createDate: DateTime.parse(json["createDate"]),
    modifiedDate: DateTime.parse(json["modifiedDate"]),
  );

}

class InforProductByStatus {

  final String fullname;
  final String email;
  final String phone;

  InforProductByStatus({
    required this.fullname,
    required this.email,
    required this.phone,
  });

  factory InforProductByStatus.fromJson(Map<String, dynamic> json) => InforProductByStatus(
    fullname: json["fullname"],
    email: json["email"],
    phone: json["phone"],
  );
}

class TicketProductByStatus {
  final int idTicket;
  final int valueTicket;
  final String typeTicket;
  final int amountTicket;
  final String note;

  TicketProductByStatus({
    required this.idTicket,
    required this.valueTicket,
    required this.typeTicket,
    required this.amountTicket,
    required this.note,
  });

  factory TicketProductByStatus.fromJson(Map<String, dynamic> json) => TicketProductByStatus(
    idTicket: json["idTicket"],
    valueTicket: json["valueTicket"],
    typeTicket: json["typeTicket"],
    amountTicket: json["amountTicket"],
    note: json["note"],
  );
}
