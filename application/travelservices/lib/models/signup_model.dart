class SignUpRequest {
  final String username;
  final String email;
  final String phone;
  final String lastname;
  final String firstname;
  final String gender;
  final String password;
  final bool provider;
  final int idRole;

  SignUpRequest(this.username, this.email, this.phone, this.password, this.lastname, this.firstname, this.gender, this.idRole, this.provider);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username' : username.trim(),
      'email' : email.trim(),
      'password' : password.trim(),
      'phone' : phone.trim(),
      'firstname' : firstname.trim(),
      'lastname' : lastname.trim(),
      'sex' : gender.trim(),
      'provider' : provider,
      'idRole' : idRole
    };
    return map;
  }  
}

class SignUpResponse {

  final int id;
  final String username;
  final String? firstname;
  final String? lastname;
  final String? phone;
  final String? email;
  final String? avatar;
  final String? sex;
  final String? role;
  final DateTime createDate;
  final DateTime modifiedDate;

  SignUpResponse({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.sex,
    required this.role,
    required this.createDate,
    required this.modifiedDate,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    id: json["id"],
    username: json["username"] ?? "",
    firstname: json["firstname"] ?? "",
    lastname: json["lastname"] ?? "",
    phone: json["phone"] ?? "",
    email: json["email"] ?? "",
    avatar: json["avatar"] ?? "",
    sex: json["sex"] ?? "",
    role: json["role"] ?? "",
    createDate: DateTime.parse(json["createDate"]),
    modifiedDate: DateTime.parse(json["modifiedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "firstname": firstname,
    "lastname": lastname,
    "phone": phone,
    "email": email,
    "avatar": avatar,
    "sex": sex,
    "role": role,
    "createDate": createDate.toIso8601String(),
    "modifiedDate": modifiedDate.toIso8601String(),
  };
}
