class TicketModel {

  final int id;
  final int? value;
  final String? type;
  final int? amount;
    
  TicketModel({
    required this.id,
    this.value,
    this.type,
    this.amount,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
    id: json["id"],
    value: json["value"],
    type: json["type"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "type": type,
    "amount": amount,
  };
  
}
