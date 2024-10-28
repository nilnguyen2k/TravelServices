class AboutAppModel {

  final int numUser;
  final int numAdmin;
  final int numService;
  final int numOrder;

  AboutAppModel({
    required this.numUser,
    required this.numAdmin,
    required this.numService,
    required this.numOrder,
  });


  factory AboutAppModel.fromJson(Map<String, dynamic> json) => AboutAppModel(
    numUser: json["numUser"],
    numAdmin: json["numAdmin"],
    numService: json["numService"],
    numOrder: json["numOrder"],
  );

}


class ChangePasswordModel {
  
  final String username;
  final String oldPassword;
  final String newPassword;

  ChangePasswordModel({
    required this.username,
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "oldPassword": oldPassword,
    "newPassword": newPassword,
  };

}