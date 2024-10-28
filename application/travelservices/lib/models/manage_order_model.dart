import 'package:travelservices/models/order_model.dart';

class OrderDataModel {

  final int id;
  final int idOrder;
  final int idService;
  final String nameService;
  final String description;
  final String url;
  final String bookDay;
  final String bookTime;
  final int total;
  final List<TicketsOrder> tickets;
  final InforUserOrder infor;
  final DateTime createDate;
  final DateTime modifiedDate;


  OrderDataModel({
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

  factory OrderDataModel.fromJson(Map<String, dynamic> json) => OrderDataModel(
    id: json["id"],
    idOrder: json["idOrder"],
    idService: json["idService"],
    nameService: json["nameService"],
    description: json["description"],
    url: json["url"],
    bookDay: json["bookDay"],
    bookTime: json["bookTime"],
    total: json["total"],
    tickets: List<TicketsOrder>.from(json["tickets"].map((x) => TicketsOrder.fromJson(x))),
    infor: InforUserOrder.fromJson(json["infor"]),
    createDate: DateTime.parse(json["createDate"]),
    modifiedDate: DateTime.parse(json["modifiedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idOrder": idOrder,
    "idService": idService,
    "nameService": nameService,
    "description": description,
    "url": url,
    "bookDay": bookDay,
    "bookTime": bookTime,
    "total": total,
    "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
    "infor": infor.toJson(),
    "createDate": createDate.toIso8601String(),
    "modifiedDate": modifiedDate.toIso8601String(),
  };
}

