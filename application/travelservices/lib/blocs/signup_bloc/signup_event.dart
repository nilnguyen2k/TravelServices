import 'package:equatable/equatable.dart';

class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpUsernameEvent extends SignUpEvent {
  final String username;
  SignUpUsernameEvent(this.username);
}

class SignUpEmailEvent extends SignUpEvent {
  final String email;
  SignUpEmailEvent(this.email);
}

class SignUpRoleEvent extends SignUpEvent {
  final int roleId;
  SignUpRoleEvent(this.roleId);
}

class SignUpProviderEvent extends SignUpEvent {
  final bool provider;
  SignUpProviderEvent(this.provider);
}

class SignUpFirstnameEvent extends SignUpEvent {
  final String firstname;
  SignUpFirstnameEvent(this.firstname);
}

class SignUpLastnameEvent extends SignUpEvent {
  final String lastname;
  SignUpLastnameEvent(this.lastname);
}

class SignUpPhoneEvent extends SignUpEvent {
  final String phone;
  SignUpPhoneEvent(this.phone);
}

class SignUpGenderEvent extends SignUpEvent {
  final String gender;
  SignUpGenderEvent(this.gender);
}

class SignUpPasswordEvent extends SignUpEvent {
  final String password;
  SignUpPasswordEvent(this.password);
}

class SignUpCnfPasswordEvent extends SignUpEvent {
  final String cnfPassword;
  SignUpCnfPasswordEvent(this.cnfPassword);
}

class SignUpSubmitEvent extends SignUpEvent {
  
  SignUpSubmitEvent();
}

class SignUpEyePasswordEvent extends SignUpEvent {
  final bool eyeStatus;
  SignUpEyePasswordEvent(this.eyeStatus);
}

class SignUpEyeCnfPasswordEvent extends SignUpEvent {
  final bool eyeStatus;
  SignUpEyeCnfPasswordEvent(this.eyeStatus);
}