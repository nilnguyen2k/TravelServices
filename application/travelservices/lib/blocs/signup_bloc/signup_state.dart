import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  
  final String username;
  final String? errorUsername;

  final String email;
  final String? errorEmail;

  final String phone;
  final String? errorPhone;

  final String firstname;
  final String lastname;
  final String gender;
  final bool provider;
  final int roleId;
  final String password;
  final String cnfpassword;

  final bool eyePassword;
  final bool eyeCnfPassword;

  final SubmitStatus status;



  const SignUpState({
    this.errorUsername,
    this.errorEmail,
    this.errorPhone,
    this.username = '',
    this.email = '',
    this.phone = '', 
    this.firstname = '',
    this.lastname = '',
    this.gender = 'Male',
    this.cnfpassword = '', 
    this.password = '',
    this.roleId = 0,
    this.eyePassword = false,
    this.eyeCnfPassword = false,
    this.provider = false,
    this.status = const InitialStatus()
  });

  SignUpState copyWith({
    String? errorUsername,
    String? errorEmail,
    String? errorPhone,
    String? username,
    String? email,
    String? phone,
    String? firstname,
    String? lastname,
    String? gender,
    int? roleId,
    String? password,
    String? cnfpassword,
    bool? eyePassword,
    bool? eyeCnfPassword,
    bool? provider,
    SubmitStatus? status,
  }) {
    return SignUpState(
      errorUsername: errorUsername ?? this.errorUsername,
      errorEmail: errorEmail ?? this.errorEmail,
      errorPhone: errorPhone ?? this.errorPhone,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      cnfpassword: cnfpassword ?? this.cnfpassword,
      eyePassword: eyePassword ?? this.eyePassword,
      eyeCnfPassword: eyeCnfPassword ?? this.eyeCnfPassword,
      provider: provider ?? this.provider,
      status: status ?? this.status,
      roleId: roleId ?? this.roleId
    );
  }
  
  @override
  List<Object?> get props => [
    errorUsername,
    errorEmail,
    errorPhone,
    gender, 
    eyePassword, 
    eyeCnfPassword, 
    username, 
    email,
    phone,
    firstname,
    lastname,
    password,
    status,
    provider,
    roleId
  ];
  
}


class SubmitStatus {
  const SubmitStatus();
}

class InitialStatus extends SubmitStatus {
  const InitialStatus();
}

class SubmittingStatus extends SubmitStatus {}

class SuccessStatus extends SubmitStatus {}

class FailedStatus extends SubmitStatus {}

