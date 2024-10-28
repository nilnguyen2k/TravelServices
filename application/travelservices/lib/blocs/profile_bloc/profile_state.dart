import 'package:equatable/equatable.dart';
import 'package:travelservices/models/profile_model.dart';

class ProfileState extends Equatable {

  final bool getLoading;
  final bool getError;
  final ProfileResponse? user;
  final String gender;
  final int updateStatus;
  final int uploadAvatar;

  const ProfileState({
    required this.getLoading,
    required this.getError,
    required this.user,
    required this.updateStatus,
    required this.gender,
    required this.uploadAvatar
  });

  factory ProfileState.empty() {
    return const ProfileState(
      getLoading: false, 
      getError: false,
      user: null, 
      updateStatus: 0,
      gender: "",
      uploadAvatar: 0
    );
  }

  ProfileState copyWith({
    bool? getLoading,
    bool? getError,
    ProfileResponse? user,
    int? updateStatus,
    String? gender,
    int? uploadAvatar
  }) {
    return ProfileState(
      getLoading: getLoading ?? this.getLoading, 
      getError: getError ?? this.getError,
      user: user ?? this.user, 
      updateStatus: updateStatus ?? this.updateStatus,
      gender: gender ?? this.gender,
      uploadAvatar: uploadAvatar ?? this.uploadAvatar
    );
  }


  @override
  List<Object?> get props => [getLoading, user, updateStatus, gender, uploadAvatar];

}