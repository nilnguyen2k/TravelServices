class RefreshTokenModel {
  
  final String accessToken;
  final String refreshToken;
  final String tokenType;

  RefreshTokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });


  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) => RefreshTokenModel(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    tokenType: json["tokenType"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "tokenType": tokenType,
  };
}