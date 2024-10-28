import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginUsernameEvent extends LoginEvent {
  final String username;
  LoginUsernameEvent(this.username);
}

class LoginPasswordEvent extends LoginEvent {
  final String password;
  LoginPasswordEvent(this.password);
}

class LoginEyePasswordEvent extends LoginEvent {
  final bool eyeStatus;
  LoginEyePasswordEvent(this.eyeStatus);
}

class LoginSubmitEvent extends LoginEvent {
  LoginSubmitEvent();
}

class LoginByProvider extends LoginEvent {
  LoginByProvider();
}
