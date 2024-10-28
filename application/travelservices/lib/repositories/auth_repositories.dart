import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/models/firebase_user_model.dart';
import 'package:travelservices/models/infor_order_model.dart';
import 'package:travelservices/models/login_model.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/profile_model.dart';
import 'package:travelservices/models/signup_model.dart';

class AuthRepository {
  Api api = Api();

  Future<Object> signUpRepo(String username, String email, String phone, String password, String lastname, String firstname, String gender, int idRole, bool provider) {
    SignUpRequest request = SignUpRequest(username, email, phone, password, lastname, firstname, gender, idRole, provider); 
    return api.postSignUp(Api.url, "auth/register", request);
  }

  Future<Object> loginRepo(String username, String password) {
    LoginRequestModel request = LoginRequestModel(username: username, password: password);
    return api.postLogin(Api.url, "auth/login", request);
  }

  Future<List<EventCalender>> getListEvent(String endPoint) async {
    var object = await api.getRequestAuth(Api.url, endPoint);
    if (object is Response) {
      return (object.data as List).map((e) => EventCalender.fromJson(e)).toList();
    } else {
      return <EventCalender>[];
    }
  }

  Future<User> loginWithProvider() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user!;
  }

  Future createUser(UserFirebase model) async {
    final docUser = FirebaseFirestore.instance.collection("users").doc(model.id.toString());
    await docUser.set(model.toJson());
  }

  Future updateStatusUser(bool status, String doc) async {
    final docUser = FirebaseFirestore.instance.collection("users").doc(doc);
    await docUser.update({
      "status" : status
    });
  }

  Future updateAvaterToFirebase(String avatar, String doc) async {
    final docUser = FirebaseFirestore.instance.collection("users").doc(doc);
    await docUser.update({
      "avatar" : avatar
    });
  }

  Future updateProfileToFirebase(String firstname, String lastname, String gender, String email, String doc) async {
    final docUser = FirebaseFirestore.instance.collection("users").doc(doc);
    await docUser.update({
      "firstname" : firstname,
      "lastname" : lastname,
      "sex" : gender,
      "email" : email
    });
  }

  Future<Object> updateProfile(String endPoint, ProfileRequest request) async {
    var object = await api.updateProfile(request, endPoint);
    if (object is Response) {
      return ProfileResponse.fromJson(object.data);
    } else {
      return MessageModel(message: "Failed");
    }
  }

  Future<Object> getProfileUser(String endPoint) async {
    var object = await api.getRequestAuth(Api.url, endPoint);
    if (object is Response) {
      return ProfileResponse.fromJson(object.data);
    } else {
      return MessageModel(message: "Failed");
    }
  } 

  Future<Object> uploadAvatar(String endPoint, File imageFile) async {
    var object = await api.uploadAvatar(endPoint, imageFile);
    if (object is Response) {
      return ProfileResponse.fromJson(object.data);
    } else {
      return MessageModel(message: "Failed");
    }
  }
  
} 