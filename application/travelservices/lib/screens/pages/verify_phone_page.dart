import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pinput/pinput.dart';
import 'package:travelservices/blocs/signup_bloc/signup_bloc.dart';
import 'package:travelservices/blocs/signup_bloc/signup_event.dart';
import 'package:travelservices/blocs/signup_bloc/signup_state.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/signupform.dart';
import 'package:travelservices/screens/arguments/typeloginarguments.dart';

class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage({Key? key}) : super(key: key);

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var codeSMS = "";
  @override
  Widget build(BuildContext context) {
    final formData = ModalRoute.of(context)!.settings.arguments as SignUpForm;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
            borderRadius: BorderRadius.circular(20),
          ),
        );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          }
        ),
        title: const Text(
          "Verification",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  "Verification code",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),
                )
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: const Text(
                  "We have sent the code verification to",
                  style: TextStyle(
                    fontSize: 16
                  ),
                )
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  formData.phone,
                  style: const TextStyle(
                    fontSize: 16
                  ),
                )
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    showCursor: true,
                    onChanged: (value) {
                      codeSMS = value;
                    },
                  ),
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.35,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: formData.phone.replaceAll("0", "+84"),
                              verificationCompleted: (PhoneAuthCredential credential){}, 
                              verificationFailed: (FirebaseAuthException e){}, 
                              codeSent: (String verificationId, int? resendToken) {}, 
                              codeAutoRetrievalTimeout: (String verificationId){}
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                            ),
                            backgroundColor: MaterialStateProperty.all(Colors.grey.shade400)
                          ), 
                          child: const Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              "Resend",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder:(context, state) {
                          if (state.status is FailedStatus) {
                            print("asdasd");
                          }
                          if (state.status is SuccessStatus) {
                            // print("1111111111111111");
                            // Navigator.pushNamed(context, Routes.login);
                          }
                          return SizedBox(
                            width: MediaQuery.of(context).size.width*0.35,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: formData.verify, smsCode: codeSMS);
                                  await auth.signInWithCredential(credential).then((value) {
                                    if (value.user != null) {
                                        context.read<SignUpBloc>().add(SignUpUsernameEvent(formData.phone));
                                        context.read<SignUpBloc>().add(SignUpEmailEvent(formData.email));
                                        context.read<SignUpBloc>().add(SignUpPhoneEvent(formData.phone));
                                        context.read<SignUpBloc>().add(SignUpLastnameEvent(formData.lastname));
                                        context.read<SignUpBloc>().add(SignUpFirstnameEvent(formData.firstname));
                                        context.read<SignUpBloc>().add(SignUpPasswordEvent(formData.password));
                                        context.read<SignUpBloc>().add(SignUpGenderEvent(formData.gender));
                                        context.read<SignUpBloc>().add(SignUpProviderEvent(formData.provider));
                                        context.read<SignUpBloc>().add(SignUpRoleEvent(formData.role));
                                        context.read<SignUpBloc>().add(SignUpSubmitEvent());
                                        showDialog(
                                          context: context, 
                                          builder: (context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15)
                                              ),
                                              child: SizedBox(
                                                height: 200,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/success.png",
                                                      height: 50,
                                                      width: 50,
                                                    ), 
                                                    const SizedBox(height: 20),
                                                    const Text(
                                                      "Successfully",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontStyle: FontStyle.italic
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        if (formData.role == 1) {
                                                          Navigator.pushNamed(context, Routes.login, arguments: TypeLogin(false, "Admin"));
                                                        } else {
                                                          Navigator.pushNamed(context, Routes.login, arguments: TypeLogin(true, "User"));
                                                        }
                                                      },
                                                      style: ButtonStyle(
                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(18.0),
                                                          )
                                                        )
                                                      ), 
                                                      child: const Text("OK")
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        );
                                    } else {
                                      MotionToast.error(
                                        height: 80,
                                        width: MediaQuery.of(context).size.width*3/4,
                                        title: const Text(
                                          "Failed",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        description: const Text("Somethong was wrong")
                                      ).show(context);
                                    }
                                  });
                                } catch (e) {
                                  MotionToast.error(
                                    height: 80,
                                    width: MediaQuery.of(context).size.width*3/4,
                                    title: const Text(
                                      "Failed",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    description: const Text("The sms code has expired or wrong. Please re-send the verification code to try again")
                                  ).show(context);
                                }
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                                ),
                                backgroundColor: MaterialStateProperty.all(Colors.green.shade400)
                              ), 
                              child: const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],    
                  )
                ],
              )
            ]
          ),
        ),
      )
    );
  }
}