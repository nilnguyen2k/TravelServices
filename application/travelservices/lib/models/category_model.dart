import 'package:travelservices/configs/constants.dart';

class CategoryData {
    
  final int id;
  final String? name;
  final String? icon;
  
  CategoryData({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
  };
}