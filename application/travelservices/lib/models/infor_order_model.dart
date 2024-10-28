class EventCalender {
  EventCalender({
    required this.service,
    required this.bookDay,
    required this.bookTime,
    required this.status,
  });

  final String service;
  final String bookDay;
  final String bookTime;
  final String status;

  factory EventCalender.fromJson(Map<String, dynamic> json) => EventCalender(
    service: json["service"],
    bookDay: json["bookDay"].toString(),
    bookTime: json["bookTime"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "service": service,
    "bookDay": bookDay,
    "bookTime": bookTime,
    "status": status,
  };
}

class InforOrder {
  InforOrder({
    required this.id,
    required this.tickets,
    required this.schedules,
  });

  final int id;
  final List<TicketInforOrder> tickets;
  final List<ScheduleInforOrder> schedules;

  factory InforOrder.fromJson(Map<String, dynamic> json) => InforOrder(
    id: json["id"],
    tickets: json["tickets"] != null ? List<TicketInforOrder>.from(json["tickets"].map((x) => TicketInforOrder.fromJson(x))) : [],
    schedules: List<ScheduleInforOrder>.from(json["schedules"].map((x) => ScheduleInforOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
    "schedules": List<dynamic>.from(schedules.map((x) => x.toJson())),
  };

  factory InforOrder.empty() {
    return InforOrder(
      id: 0, 
      tickets: [], 
      schedules: []
    );
  }
}

class TicketInforOrder {
  TicketInforOrder({
    required this.idTicket,
    required this.valueTicket,
    required this.typeTicket,
    required this.amountTicket,
    required this.note,
  });

  int idTicket;
  int valueTicket;
  String typeTicket;
  int amountTicket;
  String? note;

  factory TicketInforOrder.fromJson(Map<String, dynamic> json) => TicketInforOrder(
    idTicket: json["idTicket"],
    valueTicket: json["valueTicket"],
    typeTicket: json["typeTicket"],
    amountTicket: json["amountTicket"],
    note: json["note"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "idTicket": idTicket,
    "valueTicket": valueTicket,
    "typeTicket": typeTicket,
    "amountTicket": amountTicket,
    "note": note,
  };
}

class ScheduleInforOrder {
  
  final int id;
  final String time;
  final int quantityPerDay;

  ScheduleInforOrder({
    required this.id,
    required this.time,
    required this.quantityPerDay,
  });

  factory ScheduleInforOrder.fromJson(Map<String, dynamic> json) => ScheduleInforOrder(
    id: json["id"],
    time: json["time"],
    quantityPerDay: json["quantityPerDay"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "time": time,
    "quantityPerDay": quantityPerDay,
  };

}
