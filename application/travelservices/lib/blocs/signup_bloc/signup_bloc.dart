import 'package:bloc/bloc.dart';
import 'package:travelservices/blocs/signup_bloc/signup_event.dart';
import 'package:travelservices/blocs/signup_bloc/signup_state.dart';
import 'package:travelservices/models/firebase_user_model.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/signup_model.dart';
import 'package:travelservices/repositories/auth_repositories.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  
  final AuthRepository authRepo;

  SignUpBloc({required this.authRepo}) : super(const SignUpState()){
    on<SignUpUsernameEvent>(_onSignUpUsername);
    on<SignUpEmailEvent>(_onSignUpEmail);
    on<SignUpPhoneEvent>(_onSignUpPhone);
    on<SignUpFirstnameEvent>(_onSignUpFirstname);
    on<SignUpLastnameEvent>(_onSignUpLastname);
    on<SignUpProviderEvent>(_onSignUpProvider);
    on<SignUpRoleEvent>(_onSignUpRole);
    on<SignUpGenderEvent>(_onSignUpGender);
    on<SignUpPasswordEvent>(_onSignUpPassword);
    on<SignUpCnfPasswordEvent>(_onSignUpCnfPassword);
    on<SignUpEyePasswordEvent>(_onEyeSignUpPassword);
    on<SignUpEyeCnfPasswordEvent>(_onEyeSignUpCnfPassword);
    on<SignUpSubmitEvent>(_onSignUpSubmit);
  }

  void _onSignUpUsername(SignUpUsernameEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _onSignUpEmail(SignUpEmailEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onSignUpPhone(SignUpPhoneEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onSignUpFirstname(SignUpFirstnameEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(firstname: event.firstname));
  }

  void _onSignUpLastname(SignUpLastnameEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(lastname: event.lastname));
  }

  void _onSignUpGender(SignUpGenderEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  void _onSignUpPassword(SignUpPasswordEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: event.password));
  }
  void _onSignUpRole(SignUpRoleEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(roleId: event.roleId));
  }

  void _onSignUpCnfPassword(SignUpCnfPasswordEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(cnfpassword: event.cnfPassword));
  }

  void _onEyeSignUpPassword(SignUpEyePasswordEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(eyePassword: event.eyeStatus));
  }

  void _onEyeSignUpCnfPassword(SignUpEyeCnfPasswordEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(eyeCnfPassword: event.eyeStatus));
  }

  void _onSignUpProvider(SignUpProviderEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(provider: event.provider));
  }

  void _onSignUpSubmit(SignUpSubmitEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(status: SubmittingStatus()));
    var model = await authRepo.signUpRepo(
      state.username, 
      state.email, 
      state.phone, 
      state.password, 
      state.lastname, 
      state.firstname, 
      state.gender,
      state.roleId,
      state.provider
    );
    if (model is MessageModel) {
      emit(state.copyWith(status: FailedStatus(), errorUsername: "Username already exists"));
    }
    if (model is SignUpResponse) {
      emit(state.copyWith(status: SuccessStatus()));
      authRepo.createUser(UserFirebase(
        id: model.id, 
        username: model.username, 
        firstname: model.firstname, 
        lastname: model.lastname, 
        phone: model.phone, 
        email: model.phone, 
        avatar: model.avatar, 
        sex: model.sex, 
        role: model.role, 
        createDate: model.createDate, 
        modifiedDate: model.modifiedDate, 
        status: false
      ));
    }
    emit(state.copyWith(status: const InitialStatus()));
  }
}