import 'package:travelservices/models/schedule_model.dart';
import 'package:travelservices/models/ticket_model.dart';

class ProductData {

  final int id;
  final String? name;
  final String address;
  final String? description;
  final double? point;
  final String? image;
  final CategoryDataP category;
  final AreaDataP area;
  final List<TicketModel> ticket;
  List<ScheduleModel> schedule;
  final int reviews;
  final int orders;
  final DateTime createDate;
  final DateTime modifiedDate;

  ProductData({
    required this.id,
    this.name,
    this.description,
    this.image,
    required this.address,
    required this.point,
    required this.category,
    required this.area,
    required this.ticket,
    required this.schedule,
    required this.reviews,
    required this.orders,
    required this.createDate,
    required this.modifiedDate
  });

    factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
      id: json["id"],
      name: json["name"],
      point: json["point"],
      address: json["address"],
      description: json["description"],
      image: json["image"],
      category: CategoryDataP.fromJson(json["category"]),
      area: AreaDataP.fromJson(json["area"]),
      ticket: List<TicketModel>.from(json["ticket"].map((x) => TicketModel.fromJson(x))),
      schedule: json["schedule"] != null ? List<ScheduleModel>.from(json["schedule"].map((x) => ScheduleModel.fromJson(x))) : [],
      reviews: json["reviews"],
      orders: json["orders"],
      createDate: DateTime.parse(json["createDate"]),
      modifiedDate: DateTime.parse(json["modifiedDate"]),
    );

    Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "address" : address,
      "description": description,
      "image": image,
      "category": category,
      "area": area,
      "ticket": List<dynamic>.from(ticket.map((x) => x.toJson())),
      "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
      "reviews": reviews,
      "orders": orders,
      "point": point,
      "createDate": createDate.toIso8601String(),
      "modifiedDate": modifiedDate.toIso8601String(),
    };
    
}


class AreaDataP {
  
  final int id;
  final String? name;
  
  AreaDataP({
    required this.id,
    this.name,
  });

  factory AreaDataP.fromJson(Map<String, dynamic> json) => AreaDataP(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class CategoryDataP {
  
  final int id;
  final String? name;
  
  CategoryDataP({
    required this.id,
    this.name,
  });

  factory CategoryDataP.fromJson(Map<String, dynamic> json) => CategoryDataP(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}