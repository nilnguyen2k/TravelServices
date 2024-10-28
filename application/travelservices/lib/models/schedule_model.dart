class ScheduleModel {
  final int id;
  final int? quantityPerDay;
  final String? time;

  ScheduleModel({
    required this.id,
    this.quantityPerDay,
    this.time,
  });


  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    id: json["id"],
    quantityPerDay: json["quantity_per_day"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity_per_day": quantityPerDay,
    "time": time,
  };
}