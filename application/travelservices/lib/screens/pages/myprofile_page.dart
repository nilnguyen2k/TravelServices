import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:travelservices/blocs/profile_bloc/profile_bloc.dart';
import 'package:travelservices/blocs/profile_bloc/profile_event.dart';
import 'package:travelservices/blocs/profile_bloc/profile_state.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/repositories/auth_repositories.dart';
import 'package:travelservices/screens/arguments/change_profile_arguments.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  String gender = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        ChangeProfileArguments args = ModalRoute.of(context)!.settings.arguments as ChangeProfileArguments;
        emailController.text = args.email ?? "";
        phoneController.text = args.phone;
        lastnameController.text = args.lastname ?? "";
        firstnameController.text = args.firstname ?? "";
        gender = args.gender ?? "";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProfileBloc bloc = context.read<ProfileBloc>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "My Profile",
            style: TextStyle(
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue.shade600,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1), 
            child: Container(
              color: searchbar, 
              width: double.infinity, 
              height: 1
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
          child: ListView(
            children: [
              const SizedBox(height: 30),
              BlocConsumer<ProfileBloc, ProfileState>(
                bloc: bloc,
                listener: (context, state) {
                  if (state.uploadAvatar == 1) {
                    MotionToast.success(
                      height: 80,
                      width: MediaQuery.of(context).size.width*3/4,
                      title: const Text(
                        "Success",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      description: const Text("Successful change")
                    ).show(context);
                  }
                  if (state.uploadAvatar == -1) {
                    MotionToast.error(
                      height: 80,
                      width: MediaQuery.of(context).size.width*3/4,
                      title: const Text(
                        "Failed",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      description: const Text("Change failed")
                    ).show(context);
                  }
                },
                builder:(context, state) {
                  return Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1)
                              )
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(state.user?.infor.avatar ?? avatarDefault)
                            )
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Colors.white
                              ),
                              color: Colors.blue.shade600
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                final ImagePicker picker = ImagePicker();
                                var imagePicker = await picker.pickImage(source: ImageSource.gallery);
                                if (imagePicker != null) {
                                  bloc.add(ProfileUploadAvatarEvent(file: File(imagePicker.path)));
                                }
                              },
                              color: Colors.white,
                              iconSize: 15,
                            ),
                          )
                        )
                      ],
                    ),
                  ); 
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: lastnameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        prefixIcon: const Icon(Icons.person),
                        label: const Text("Lastname"),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: TextFormField(
                      controller: firstnameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        prefixIcon: const Icon(Icons.person),
                        label: const Text("Firstname"),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  prefixIcon: const Icon(Icons.email),
                  label: const Text("Email"),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 30),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black38),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder:(context, state) {
                    return Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              gender = "Male";
                              context.read<ProfileBloc>().add(ProfileGenderEvent(gender: gender));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: gender == "Male" ? Colors.blue.shade600 : Colors.white,
                                border: Border.all(width: 1, color: Colors.black38),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)
                                )
                              ),
                              child: Text(
                                "Male",
                                style: TextStyle(
                                  color: gender== "Male" ? Colors.white : Colors.black54
                                ),
                              )
                            ),
                          )
                        ),
                        const VerticalDivider(
                          width: 2,
                          color: Colors.black,
                        ),
                        Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              gender = "Female";
                              context.read<ProfileBloc>().add(ProfileGenderEvent(gender: gender));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: gender == "Female" ? Colors.blue.shade600 : Colors.white,
                                border: Border.all(width: 1, color: Colors.black38),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15)
                                )
                              ),
                              child: Text(
                                "Female",
                                style: TextStyle(
                                  color: gender == "Female" ? Colors.white : Colors.black54
                                ),
                              )
                            ),
                          )
                        ),
                      ],
                    );
                  },
                )
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  prefixIcon: const Icon(Icons.phone),
                  label: const Text("Phone"),
                  enabled: false
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/2.5,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                          )
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.grey.shade200)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                          ),
                        ),
                      ),  
                    )
                  ),
                  BlocConsumer<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state.updateStatus == 1) {
                        MotionToast.success(
                          height: 80,
                          width: MediaQuery.of(context).size.width*3/4,
                          title: const Text(
                            "Success",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          description: const Text("Successful change")
                        ).show(context);
                      }
                      if (state.updateStatus == -1) {
                        MotionToast.error(
                          height: 80,
                          width: MediaQuery.of(context).size.width*3/4,
                          title: const Text(
                            "Failed",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          description: const Text("Change failed")
                        ).show(context);
                      }
                    },
                    builder:(context, state) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width/2.5,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){
                            context.read<ProfileBloc>().add(ProfileUpdateEvent(
                              firstname: firstnameController.text, 
                              lastname: lastnameController.text, 
                              email: emailController.text, 
                              gender: gender
                            ));
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                              )
                            ),
                            backgroundColor: MaterialStateProperty.all(Colors.blue.shade400)
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),  
                        )
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}