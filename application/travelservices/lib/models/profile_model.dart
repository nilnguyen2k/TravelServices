class ProfileRequest {
    
  final String firstname;
  final String lastname;
  final String email;
  final String gender;

  ProfileRequest({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "gender": gender,
  };
}


class ProfileResponse {
    
  final int numOrderWaiting;
  final int numOrderApproved;
  final int numOrderExperienced;
  final int numServiceForAdmin;
  final int numOrderForAdmin;
  final InforProfile infor;

  ProfileResponse({
    required this.numOrderWaiting,
    required this.numOrderApproved,
    required this.numOrderExperienced,
    required this.numServiceForAdmin,
    required this.numOrderForAdmin,
    required this.infor,
  });

    factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
        numOrderWaiting: json["numOrderWaiting"],
        numOrderApproved: json["numOrderApproved"],
        numOrderExperienced: json["numOrderExperienced"],
        numServiceForAdmin: json["numServiceForAdmin"],
        numOrderForAdmin: json["numOrderForAdmin"],
        infor: InforProfile.fromJson(json["infor"]),
    );
}

class InforProfile {
    
  final int id;
  final String? avatar;
  final String? email;
  final String? firstname;
  final String? lastname;
  final String phone;
  final String? sex;
  final String? role;

  InforProfile({
    required this.id,
    required this.avatar,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.sex,
    required this.role,
  });

  factory InforProfile.fromJson(Map<String, dynamic> json) => InforProfile(
    id: json["id"],
    avatar: json["avatar"] ?? "",
    email: json["email"] ?? "",
    firstname: json["firstname"] ?? "",
    lastname: json["lastname"] ?? "",
    phone: json["phone"],
    sex: json["sex"] ?? "",
    role: json["role"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "avatar": avatar,
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
    "phone": phone,
    "sex": sex,
    "role": role,
  };
}
