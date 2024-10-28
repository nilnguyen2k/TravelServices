class ProductDetailsModel {

  final int? id;
  final int? createByAuthId;
  final String? usernameAuth;
  String? name;
  String? address;
  String area;
  String category;
  String? description;
  String? event;
  String? note;
  int? minPrice;
  List<ReviewProductDetailsModel> reviews;
  List<GalleryDetailsModel> galleries;

  ProductDetailsModel({
    required this.id,
    required this.createByAuthId,
    required this.usernameAuth,
    required this.name,
    this.address = '',
    this.description = '',
    this.event = '',
    this.note = '',
    required this.minPrice,
    required this.reviews,
    required this.galleries,
    required this.area,
    required this.category
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
    id: json["id"],
    createByAuthId: json["createByAuthId"],
    area: json["area"],
    category: json["category"],
    usernameAuth: json["usernameAuth"],
    name: json["name"],
    address: json["address"],
    description: json["description"],
    event: json["event"],
    note: json["note"],
    minPrice: json["minPrice"],
    reviews: List<ReviewProductDetailsModel>.from(json["reviews"].map((x) => ReviewProductDetailsModel.fromJson(x))),
    galleries: List<GalleryDetailsModel>.from(json["galleries"].map((x) => GalleryDetailsModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "createByAuthId": createByAuthId,
    "usernameAuth": usernameAuth,
    "address": address,
    "description": description,
    "event": event,
    "note": note,
    "minPrice": minPrice,
    "area": area,
    "category": category,
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
    "galleries": List<dynamic>.from(galleries.map((x) => x.toJson())),
  };
}


class ReviewProductDetailsModel {

  final int id;
  final String content;
  final double point;
  final DateTime createDate;
  final DateTime modifiedDate;
  UserReviewModel user;

  ReviewProductDetailsModel({
    required this.id,
    required this.content,
    required this.point,
    required this.createDate,
    required this.modifiedDate,
    required this.user,
  });

  factory ReviewProductDetailsModel.fromJson(Map<String, dynamic> json) => ReviewProductDetailsModel(
    id: json["id"],
    content: json["content"],
    point: json["point"].toDouble(),
    createDate: DateTime.parse(json["createDate"]),
    modifiedDate: DateTime.parse(json["modifiedDate"]),
    user: UserReviewModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "point": point,
    "createDate": createDate.toIso8601String(),
    "modifiedDate": modifiedDate.toIso8601String(),
    "user": user.toJson(),
  };
}

class UserReviewModel {
  final int id;
  final String? lastname;
  final String? firstname;
  final String? avatar;
  
  UserReviewModel({
    required this.id,
    required this.lastname,
    required this.firstname,
    required this.avatar,
  });

  factory UserReviewModel.fromJson(Map<String, dynamic> json) => UserReviewModel(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "avatar": avatar,
  };
}

class GalleryDetailsModel {

  final int id;
  final String? url;
  final String? type;

  GalleryDetailsModel({
    required this.id,
    required this.url,
    required this.type,
  });

  factory GalleryDetailsModel.fromJson(Map<String, dynamic> json) => GalleryDetailsModel(
      id: json["id"],
      url: json["url"],
      type: json["type"],
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "url": url,
      "type": type,
  };

}

