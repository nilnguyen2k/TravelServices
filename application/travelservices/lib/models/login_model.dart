class LoginRequestModel {
  final String username;
  final String password;

  LoginRequestModel({
    required this.username,
    required this.password,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => LoginRequestModel(
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}

class LoginResponseModel {
  final int id;
  final String username;
  final String email;
  final List<String> roles;
  final String refreshToken;
  final String accessToken;
  final String tokenType;
  final bool provider;
  final String phone;

  LoginResponseModel({
    required this.id,
    required this.username,
    required this.email,
    required this.roles,
    required this.refreshToken,
    required this.accessToken,
    required this.tokenType,
    required this.provider,
    required this.phone
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    refreshToken: json["refreshToken"],
    accessToken: json["accessToken"],
    tokenType: json["tokenType"],
    provider: json["provider"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "refreshToken": refreshToken,
    "accessToken": accessToken,
    "tokenType": tokenType,
    "provider": provider,
    "phone": phone,
  };
}
