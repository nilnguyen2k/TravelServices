import 'dart:io';

import 'package:equatable/equatable.dart';

class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileReadEvent extends ProfileEvent {
  ProfileReadEvent();
}

class ProfileUpdateEvent extends ProfileEvent {
  final String firstname;
  final String lastname;
  final String email;
  final String gender;

  ProfileUpdateEvent({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.gender
  });
}

class ProfileGenderEvent extends ProfileEvent {
  final String gender;
  ProfileGenderEvent({
    required this.gender
  });
}

class ProfileUploadAvatarEvent extends ProfileEvent {
  final File file;
  ProfileUploadAvatarEvent({
    required this.file
  });
}