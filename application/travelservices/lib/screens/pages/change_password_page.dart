import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/untils_model.dart';
import 'package:travelservices/utils/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController cnfPasswordController = TextEditingController();

  List<bool> visible = [true, true, true];

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Change Password",
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: paddingWidth*2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Your new password must be different from previous used passwords",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic
                  ),
                ),
                const SizedBox(height: 70),
                TextFormField(
                  controller: oldPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    prefixIcon: const Icon(Icons.key),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          visible[0] = !visible[0]; 
                        });
                      },
                      icon: const Icon(Icons.visibility),
                    ),
                    label: const Text("Old Password"),
                  ),
                  obscureText: visible[0],
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: newPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    prefixIcon: const Icon(Icons.key),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          visible[1] = !visible[1];
                        }); 
                      },
                      icon: const Icon(Icons.visibility),
                    ),
                    label: const Text("New Password"),
                  ),
                  obscureText: visible[1],
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: cnfPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    prefixIcon: const Icon(Icons.key),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          visible[2] = !visible[2];
                        }); 
                      },
                      icon: const Icon(Icons.visibility),
                    ),
                    label: const Text("Confirm Password"),
                  ),
                  obscureText: visible[2],
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () async {
                      Api api = Api();
                      String username = await SharedPreferencesCustom.getStringCustom('username');
                      MessageModel message = await api.postChangePassword(Api.url, 'auth/changepassword', ChangePasswordModel(
                        username: username, 
                        oldPassword: oldPasswordController.text, 
                        newPassword: newPasswordController.text
                      ));
                      if (message.message == "Success") {
                        if (!mounted) return;
                        MotionToast.success(
                          height: 80,
                          width: MediaQuery.of(context).size.width*3/4,
                          title: const Text(
                            "Success",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          description: const Text("Change success")
                        ).show(context);
                      } else {
                        if (!mounted) return;
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
                        "Update",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      )
    ); 
  }
}