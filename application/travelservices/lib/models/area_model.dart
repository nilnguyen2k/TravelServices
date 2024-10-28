class AreaData {
    
  final int id;
  final String? name;
  final String? url;
  
  AreaData({
    required this.id,
    required this.name,
    required this.url,
  });

  factory AreaData.fromJson(Map<String, dynamic> json) => AreaData(
    id: json["id"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
  };
}

class AreaFavorite {
    
  final int idArea;
  final String? nameArea;
  final String? url;
  
  AreaFavorite({
    required this.idArea,
    required this.nameArea,
    required this.url,
  });

  factory AreaFavorite.fromJson(Map<String, dynamic> json) => AreaFavorite(
    idArea: json["idArea"],
    nameArea: json["nameArea"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "idArea": idArea,
    "nameArea": nameArea,
    "url": url,
  };
}