class FavoriteResponseModel {

  final int idService;
  final String name;
  final String image;
  final int reviews;
  final dynamic pointReviews;
  final int orders;
  final int minPrice;

  FavoriteResponseModel({
    required this.idService,
    required this.name,
    required this.image,
    required this.reviews,
    required this.pointReviews,
    required this.orders,
    required this.minPrice,
  });

  factory FavoriteResponseModel.fromJson(Map<String, dynamic> json) => FavoriteResponseModel(
    idService: json["idService"],
    name: json["name"],
    image: json["image"],
    reviews: json["reviews"],
    pointReviews: json["pointReviews"],
    orders: json["orders"],
    minPrice: json["minPrice"],
  );

  Map<String, dynamic> toJson() => {
    "idService": idService,
    "name": name,
    "image": image,
    "reviews": reviews,
    "pointReviews": pointReviews,
    "orders": orders,
    "minPrice": minPrice,
  };
}
