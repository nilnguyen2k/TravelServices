import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final String? typeObject;
  final bool eyeStatus;
  final SubmitStatus status;
  final int statusProvider;


  const LoginState({
    required this.username,
    required this.password,
    required this.eyeStatus,
    required this.status,
    required this.statusProvider,
    required this.typeObject
  });

  factory LoginState.empty() {
    return const LoginState(
      username: "", 
      password: "", 
      eyeStatus: false, 
      status: InitialStatus(),
      statusProvider: 0,
      typeObject: null
    );
  }

  LoginState copyWith({
    String? username,
    String? password,
    bool? eyeStatus,
    SubmitStatus? status,
    int? statusProvider,
    String? typeObject
  }) {
    return LoginState(
      username: username ?? this.username, 
      password: password ?? this.password, 
      eyeStatus: eyeStatus ?? this.eyeStatus,
      status: status ?? this.status,
      statusProvider: statusProvider ?? this.statusProvider,
      typeObject: typeObject ?? this.typeObject
    );
  }
  
  @override
  List<Object?> get props => [username, password, eyeStatus, status, statusProvider, typeObject];
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