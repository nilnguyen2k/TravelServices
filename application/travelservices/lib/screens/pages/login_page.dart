import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelservices/blocs/login_bloc/login_bloc.dart';
import 'package:travelservices/blocs/login_bloc/login_event.dart';
import 'package:travelservices/blocs/login_bloc/login_state.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/typeloginarguments.dart';
import 'package:travelservices/utils/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _keyLoginForm = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as TypeLogin;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "Sign In",
            style: TextStyle(
              color: Colors.black
            ),
          ),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black
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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.04),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 200,
                ),
                Form(
                  key: _keyLoginForm,
                  child: Column(
                    children: [
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              prefixIcon: const Icon(Icons.phone),
                              label: const Text("Phone"),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          );
                        }
                      ),
                      const SizedBox(height: 30),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              prefixIcon: const Icon(Icons.key),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context.read<LoginBloc>().add(LoginEyePasswordEvent(!state.eyeStatus));
                                }, 
                                icon: state.eyeStatus ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)
                              ),
                              label: const Text("Password"),
                            ),
                            obscureText: !state.eyeStatus,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          );
                        }
                      ),
                      const SizedBox(height: 30),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context,state) {
                          if (state.status is SubmittingStatus) {
                            return const CircularProgressIndicator();
                          }
                          if (state.status is FailedStatus) {
                            Future.delayed(Duration.zero, () {
                              MotionToast.error(
                                height: 80,
                                width: MediaQuery.of(context).size.width*3/4,
                                title: const Text(
                                  "Incorrect password",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                description: const Text("Your phone and password is incorrect. Please try agin")
                              ).show(context);
                            });
                          }
                          if (state.status is SuccessStatus) {
                            if (args.type) {
                              if (state.typeObject == "USER") {
                                Future.delayed(Duration.zero, () {
                                  Navigator.of(context).pushNamed(Routes.routesPage);
                                });
                              } else {
                                Future.delayed(Duration.zero, () async {
                                  MotionToast.error(
                                    height: 80,
                                    width: MediaQuery.of(context).size.width*3/4,
                                    title: const Text(
                                      "Incorrect password",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    description: const Text("Your phone and password is incorrect. Please try agin")
                                  ).show(context);
                                  SharedPreferences preferences = await SharedPreferences.getInstance();
                                  await preferences.clear();     
                                  SharedPreferencesCustom.setBoolCustom('isLogined', false);
                                });
                                
                              }
                            } else {
                              if (state.typeObject == "ADMIN") {
                                Future.delayed(Duration.zero, () {
                                  Navigator.of(context).pushNamed(Routes.routePageAdmin);
                                });
                              } else {
                                Future.delayed(Duration.zero, () async {
                                  MotionToast.error(
                                    height: 80,
                                    width: MediaQuery.of(context).size.width*3/4,
                                    title: const Text(
                                      "Incorrect password",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    description: const Text("Your phone and password is incorrect. Please try agin")
                                  ).show(context);
                                  SharedPreferences preferences = await SharedPreferences.getInstance();
                                  await preferences.clear();     
                                  SharedPreferencesCustom.setBoolCustom('isLogined', false);
                                });
                              }
                            }
                          }
                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: (){
                                if (_keyLoginForm.currentState!.validate()){ 
                                  context.read<LoginBloc>().add(LoginUsernameEvent(usernameController.text));
                                  context.read<LoginBloc>().add(LoginPasswordEvent(passwordController.text));   
                                  context.read<LoginBloc>().add(LoginSubmitEvent());
                                }
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                                ),
                                backgroundColor: MaterialStateProperty.all(Colors.blue.shade400)
                              ), 
                              child: const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: (){}, 
                          child: const Text(
                            "Forgot Password",
                            style: TextStyle(
                              color: Colors.black87
                            ),
                          )
                        ),
                      ),
                      args.type ? Column(
                        children: [
                          Row(
                            children: const [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 60),
                                  child: Divider(color: Colors.black),
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text("OR"),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 60),
                                  child: Divider(color: Colors.black),
                                )
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder:(context, state) {
                              return SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: (){
                                    context.read<LoginBloc>().add(LoginByProvider());
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                                    ),
                                    backgroundColor: MaterialStateProperty.all(Colors.red.shade400)
                                  ), 
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/images/google.png"),
                                        const SizedBox(width: 15),
                                        const Text(
                                          "Sign in with google",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ) : const SizedBox.shrink(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, Routes.register, arguments: TypeLogin(args.type, args.typeName));
                            }, 
                            child: const Text("Sign Up")
                          )
                        ],
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}