import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/blocs/profile_bloc/profile_bloc.dart';
import 'package:travelservices/blocs/profile_bloc/profile_event.dart';
import 'package:travelservices/blocs/profile_bloc/profile_state.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/login_model.dart';
import 'package:travelservices/repositories/auth_repositories.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/change_profile_arguments.dart';
import 'package:travelservices/screens/arguments/status_order_arguments.dart';
import 'package:travelservices/screens/widgets/loading_widget.dart';
import 'package:travelservices/utils/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Profile",
            style: TextStyle(
              color: Colors.black
            ),
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: Api.getToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var dataSnapshot = snapshot.data as LoginResponseModel;
            ProfileBloc bloc = context.read<ProfileBloc>();
            bloc.add(ProfileReadEvent());
            return SafeArea(
              child: BlocBuilder<ProfileBloc, ProfileState>(
                bloc: bloc,
                builder:(context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 250,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 1,
                                    child: SizedBox(
                                      height: 180,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              getNameUser(state.user?.infor.firstname ?? "", state.user?.infor.lastname ?? "", dataSnapshot.roles[0]),
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.blue.shade400
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                dataSnapshot.roles[0] == "USER" ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(context, Routes.productByStatus, arguments: StatusOrderArguments(status: "approved"));
                                                  },
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        "Approved",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: hintText,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${state.user?.numOrderApproved ?? 0}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.blue.shade400
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ) : Column(
                                                  children: [
                                                    const Text(
                                                      "Services",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: hintText,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${state.user?.numServiceForAdmin ?? 0}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.blue.shade400
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 8,
                                                  ),
                                                  child: Container(
                                                    height: 35,
                                                    width: 3,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(100),
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                dataSnapshot.roles[0] == "USER" ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(context, Routes.productByStatus, arguments: StatusOrderArguments(status: "waiting"));
                                                  },
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        "Pending",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: hintText,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${state.user?.numOrderWaiting ?? 0}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.blue.shade400
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ) : Column(
                                                  children: [
                                                    const Text(
                                                      "Orders",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: hintText,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${state.user?.numOrderForAdmin ?? 0}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.blue.shade400
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    width: 120,
                                    height: 120,
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
                                        image: NetworkImage(state.user?.infor.avatar ?? avatarDefault)
                                      )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: paddingWidth),
                            child: SizedBox(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                                    child: Row(
                                      children: const [
                                        Expanded(
                                          child: Divider(
                                            thickness: 2,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: paddingWidth),
                                          child: Text(
                                            "About the app",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Divider(
                                            thickness: 2,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        menuProfile("Introduce", Icons.info, (){
                                          Navigator.pushNamed(context, Routes.aboutAppPage);
                                        }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                                  child: Row(
                                    children: const [
                                      Expanded(
                                        child: Divider(
                                          thickness: 2,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: paddingWidth),
                                        child: Text(
                                          "Manage",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          thickness: 2,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child: Column(
                                    children: [
                                      menuProfile("My Profile", Icons.person, (){
                                        Navigator.pushNamed(context, Routes.myprofilePage, arguments: ChangeProfileArguments(
                                          firstname: state.user?.infor.firstname, 
                                          lastname: state.user?.infor.lastname, 
                                          email: state.user?.infor.email, 
                                          phone: state.user?.infor.phone ?? "", 
                                          gender: state.user?.infor.sex ?? ""
                                        ));
                                      }),
                                      dataSnapshot.roles[0] == "USER" ? menuProfile("Reviews", Icons.reviews, () {
                                        Navigator.pushNamed(context, Routes.reviewsPage);
                                      }) : const SizedBox.shrink(),
                                      menuProfile("Change Password", Icons.key, (){
                                        Navigator.pushNamed(context, Routes.changepasswordPage);
                                      }),
                                      menuProfile(
                                        "Logout", 
                                        Icons.logout, 
                                        () async {
                                          AuthRepository authRepo = AuthRepository();
                                          authRepo.updateStatusUser(false, dataSnapshot.id.toString());
                                          SharedPreferences preferences = await SharedPreferences.getInstance();
                                          await preferences.clear();
                                          if (!mounted) return;
                                          Navigator.of(context).pushNamedAndRemoveUntil(Routes.optionPage, (Route<dynamic> route) => false);
                                          SharedPreferencesCustom.setBoolCustom('isLogined', false);
                                      })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]
                      ),
                    ),
                  );
                },
              )
            );
          } else {
            return const LoadingWidget();
          }
        },
      )
    );
  }

  Widget menuProfile(String text, IconData icon, GestureTapCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          backgroundColor: const Color.fromARGB(255, 236, 235, 235),
          primary: Colors.black
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Icon(
                icon,
                size: 25,
                color: Colors.blue.shade600,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  color: hintText,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            Icon(
              Icons.navigate_next,
              size: 35,
              color: Colors.blue.shade600,
            ),
          ]
        ),
      ),
    );
  }
  
  String getNameUser(String firstname, String lastname, String object) {
    if (lastname.isEmpty) {
      if (firstname.isEmpty) {
        if (object == "ADMIN") {
          return "Organizer";
        } else {
          return "Customer";
        }
      } else {
        return firstname;
      }
    } else {
      if (firstname.isEmpty) {
        return lastname;
      } else {
        return "$firstname $lastname";
      }
    }
  }
}