class UserFirebase {

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
  final bool status;

  UserFirebase({
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
    required this.status
  });

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
    "createDate": createDate,
    "modifiedDate": modifiedDate,
    "status" : status
  };

  factory UserFirebase.fromJson(Map<String, dynamic> json) => UserFirebase(
    id: json["id"],
    username: json["username"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    phone: json["phone"],
    email: json["email"],
    avatar: json["avatar"],
    sex: json["sex"],
    role: json["role"],
    createDate: DateTime.parse(json["createDate"]),
    modifiedDate: DateTime.parse(json["modifiedDate"]),
    status: json["status"],
  );
}
