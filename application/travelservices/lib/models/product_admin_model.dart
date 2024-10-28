class CreateProduct {
  final InforProduct service;
  final List<TicketForProductForAdd> ticket;
  final List<ScheduleProductForAdd> schedule;
  final List<GalleryProduct> galleries;

  CreateProduct({
    required this.service,
    required this.ticket,
    required this.schedule,
    required this.galleries,
  });

  Map<String, dynamic> toJson() => {
    "service": service.toJson(),
    "ticket": List<dynamic>.from(ticket.map((x) => x.toJson())),
    "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
    "galleries": List<dynamic>.from(galleries.map((x) => x.toJson())),
  };
}

class UpdateProduct {
  final InforProductUpdate service;
  final List<TicketForProductForUpdate> ticket;
  final List<ScheduleProductForUpdate> schedule;
  final List<GalleryProduct> galleries;

  UpdateProduct({
    required this.service,
    required this.ticket,
    required this.schedule,
    required this.galleries,
  });

  Map<String, dynamic> toJson() => {
    "service": service.toJson(),
    "ticket": List<dynamic>.from(ticket.map((x) => x.toJson())),
    "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
    "galleries": List<dynamic>.from(galleries.map((x) => x.toJson())),
  };
}

class InforProductUpdate {
  
  final String name;
  final String address;
  final String description;
  final String event;
  final String note;

  InforProductUpdate({
    required this.name,
    required this.address,
    required this.description,
    required this.event,
    required this.note,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "description": description,
    "event": event,
    "note": note,
  };
}

class TicketForProductForUpdate {
  
  final int idTicket;
  final int valueTicket;
  final String typeTicket;
  final String note;
  final int amountTicket;
  
  TicketForProductForUpdate({
    required this.idTicket,
    required this.valueTicket,
    required this.typeTicket,
    required this.note,
    required this.amountTicket,
  });

  Map<String, dynamic> toJson() => {
    "idTicket": idTicket,
    "valueTicket": valueTicket,
    "typeTicket": typeTicket,
    "note": note,
    "amountTicket": amountTicket,
  };
}

class CreateTicket {
  
  final int idService;
  final int valueTicket;
  final String typeTicket;
  final String noteTicket;
  final int amountTicket;
  
  CreateTicket({
    required this.idService,
    required this.valueTicket,
    required this.typeTicket,
    required this.noteTicket,
    required this.amountTicket,
  });

  Map<String, dynamic> toJson() => {
    "idService": idService,
    "valueTicket": valueTicket,
    "typeTicket": typeTicket,
    "noteTicket": noteTicket,
    "amountTicket": amountTicket,
  };
}

class ScheduleProductForUpdate {
  final int id;
  final String time;
  final int quantityPerDay;

  ScheduleProductForUpdate({
    required this.id,
    required this.time,
    required this.quantityPerDay,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "time": time,
    "quantityPerDay": quantityPerDay,
  };

}

class CreateSchedule {
  final int idService;
  final String time;
  final int quantityPerDay;

  CreateSchedule({
    required this.idService,
    required this.time,
    required this.quantityPerDay,
  });

  Map<String, dynamic> toJson() => {
    "idService": idService,
    "time": time,
    "quantityPerDay": quantityPerDay,
  };

}






class ProductShow {
  final ProductForAdmin service;
  final List<TicketProductDetails> ticket;
  final List<ScheduleDetails> schedule;
  final List<GalleryProduct> galleries;

  ProductShow({
    required this.service,
    required this.ticket,
    required this.galleries,
    required this.schedule,
  });

  factory ProductShow.fromJson(Map<String, dynamic> json) => ProductShow(
    service: ProductForAdmin.fromJson(json["service"]),
    ticket: List<TicketProductDetails>.from(json["ticket"].map((x) => TicketProductDetails.fromJson(x))),
    galleries: List<GalleryProduct>.from(json["galleries"].map((x) => GalleryProduct.fromJson(x))),
    schedule: List<ScheduleDetails>.from(json["schedule"].map((x) => ScheduleDetails.fromJson(x))),
  );

}

class ProductForAdmin {
  final int idService;
  final String name;
  final String description;
  final String event;
  final String area;
  final String category;

  ProductForAdmin({
    required this.idService,
    required this.name,
    required this.description,
    required this.event,
    required this.area,
    required this.category,
  });

  factory ProductForAdmin.fromJson(Map<String, dynamic> json) => ProductForAdmin(
    idService: json["idService"],
    name: json["name"],
    description: json["description"],
    event: json["event"] ?? "",
    area: json["area"],
    category: json["category"],
  );
}


class ProductDetails {
  final InforProductDetails service;
  final List<TicketProductDetails> ticket;
  final List<ScheduleDetails> schedule;
  final List<GalleryDetailsProduct> galleries;

  ProductDetails({
    required this.service,
    required this.ticket,
    required this.galleries,
    required this.schedule,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    service: InforProductDetails.fromJson(json["service"]),
    ticket: List<TicketProductDetails>.from(json["ticket"].map((x) => TicketProductDetails.fromJson(x))),
    galleries: List<GalleryDetailsProduct>.from(json["galleries"].map((x) => GalleryDetailsProduct.fromJson(x))),
    schedule: List<ScheduleDetails>.from(json["schedule"].map((x) => ScheduleDetails.fromJson(x))),
  );
}

class AreaProductResponse {
  final int id;
  final String name;
  final String url;

  AreaProductResponse({
    required this.id,
    required this.name,
    required this.url,
  });

  factory AreaProductResponse.fromJson(Map<String, dynamic> json) => AreaProductResponse(
    id: json["id"],
    name: json["name"],
    url: json["url"],
  );
}

class CategoryProductResponse {
  
  final int id;
  final String name;
  final String icon;

  CategoryProductResponse({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory CategoryProductResponse.fromJson(Map<String, dynamic> json) => CategoryProductResponse(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
  );
}

class InforProductDetails {

  final int id;
  final String name;
  final String address;
  final String description;
  final String event;
  final dynamic note;
  final CategoryProductResponse category;
  final AreaProductResponse area;

  InforProductDetails({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.event,
    required this.note,
    required this.category,
    required this.area,
  });

    
  factory InforProductDetails.fromJson(Map<String, dynamic> json) => InforProductDetails(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    description: json["description"],
    event: json["event"],
    note: json["note"],
    category: CategoryProductResponse.fromJson(json["category"]),
    area: AreaProductResponse.fromJson(json["area"]),
  );
}

class ScheduleDetails {

  ScheduleDetails({
    required this.id,
    required this.time,
    required this.quantityPerDay,
  });

  final int id;
  final String time;
  final int quantityPerDay;

  factory ScheduleDetails.fromJson(Map<String, dynamic> json) => ScheduleDetails(
    id: json["id"],
    time: json["time"],
    quantityPerDay: json["quantityPerDay"],
  );
}
class GalleryProduct {
  final int id;
  final String url;
  final String type;

  GalleryProduct({
    required this.id,
    required this.url,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "type": type,
  };

  factory GalleryProduct.fromJson(Map<String, dynamic> json) => GalleryProduct(
    id: json["id"],
    url: json["url"],
    type: json["type"],
  );
}

class GalleryDetailsProduct {
  final int id;
  final String url;
  final String type;
  final String publicId;

  GalleryDetailsProduct({
    required this.id,
    required this.url,
    required this.type,
    required this.publicId
  });

  factory GalleryDetailsProduct.fromJson(Map<String, dynamic> json) => GalleryDetailsProduct(
    id: json["id"],
    url: json["url"],
    type: json["type"],
    publicId: json["publicId"]
  );
}

class ScheduleProductForAdd {
  final String time;
  final int quantityPerDay;

  ScheduleProductForAdd({
    required this.time,
    required this.quantityPerDay,
  });

  Map<String, dynamic> toJson() => {
    "time": time,
    "quantityPerDay": quantityPerDay,
  };

}


class InforProduct {
  
  final String name;
  final String address;
  final String description;
  final String event;
  final String note;
  final int idArea;
  final int idCategory;

  InforProduct({
    required this.name,
    required this.address,
    required this.description,
    required this.event,
    required this.note,
    required this.idArea,
    required this.idCategory,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "description": description,
    "event": event,
    "note": note,
    "idArea": idArea,
    "idCategory": idCategory,
  };

}

class TicketForProductForAdd {
  
  final int valueTicket;
  final String typeTicket;
  final String noteTicket;
  final int amountTicket;
  
  TicketForProductForAdd({
    required this.valueTicket,
    required this.typeTicket,
    required this.noteTicket,
    required this.amountTicket,
  });

  Map<String, dynamic> toJson() => {
    "valueTicket": valueTicket,
    "typeTicket": typeTicket,
    "noteTicket": noteTicket,
    "amountTicket": amountTicket,
  };

}

class TicketProductDetails {
  
  final int idTicket;
  final int valueTicket;
  final String typeTicket;
  final int amountTicket;
  final String? note;
  
  TicketProductDetails({
    required this.idTicket,
    required this.valueTicket,
    required this.typeTicket,
    required this.amountTicket,
    required this.note,
  });

  factory TicketProductDetails.fromJson(Map<String, dynamic> json) => TicketProductDetails(
    idTicket: json["idTicket"],
    valueTicket: json["valueTicket"],
    typeTicket: json["typeTicket"],
    amountTicket: json["amountTicket"],
    note: json["note"] ?? "",
  );
}



