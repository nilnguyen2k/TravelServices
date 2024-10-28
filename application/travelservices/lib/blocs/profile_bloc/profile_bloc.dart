import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/profile_bloc/profile_event.dart';
import 'package:travelservices/blocs/profile_bloc/profile_state.dart';
import 'package:travelservices/models/profile_model.dart';
import 'package:travelservices/repositories/auth_repositories.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AuthRepository authRepo = AuthRepository();
  ProfileBloc() : super(ProfileState.empty()) {
    on<ProfileReadEvent>(onReadProfile);
    on<ProfileUpdateEvent>(onUpdateProfile);
    on<ProfileGenderEvent>(onGenderProfile);
    on<ProfileUploadAvatarEvent>(onUploadAvatar);
  }

  void onReadProfile(ProfileReadEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(getLoading: true));
    var data = await authRepo.getProfileUser("user/profile");
    if (data is ProfileResponse) {
      emit(state.copyWith(getLoading: false, user: data));
    } else {
      emit(state.copyWith(getError: true));
    }
  }

  void onUpdateProfile(ProfileUpdateEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(getLoading: true));
    var data = await authRepo.updateProfile("user/profile", ProfileRequest(
      firstname: event.firstname, 
      lastname: event.lastname, 
      email: event.email, 
      gender: event.gender
    ));
    if (data is ProfileResponse) {
      emit(state.copyWith(updateStatus: 1, getLoading: false, user: data));
    } else {
      emit(state.copyWith(updateStatus: -1, getLoading: false));
    }
    emit(state.copyWith(updateStatus: 0));
    authRepo.updateProfileToFirebase(
      state.user?.infor.firstname ?? "", 
      state.user?.infor.lastname ?? "",
      state.user?.infor.sex ?? "",
      state.user?.infor.email ?? "" ,
      state.user?.infor.id.toString() ?? "0"
    );
  }


  void onGenderProfile(ProfileGenderEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  void onUploadAvatar(ProfileUploadAvatarEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(getLoading: true));
    var data = await authRepo.uploadAvatar("avatar/upload", event.file);
    if (data is ProfileResponse) {
      emit(state.copyWith(user: data, uploadAvatar: 1, getLoading: false));
    } else {
      emit(state.copyWith(uploadAvatar: -1, getLoading: false));
    }
    emit(state.copyWith(uploadAvatar: 0));
    authRepo.updateAvaterToFirebase(state.user?.infor.avatar.toString() ?? "", state.user?.infor.id.toString() ?? "0");
  }

}