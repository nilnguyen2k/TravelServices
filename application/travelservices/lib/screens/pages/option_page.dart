import 'package:flutter/material.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/typeloginarguments.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(paddingWidth, paddingWidth*5, paddingWidth, 0),
              child: Text(
                "Welcome to FTService",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue.shade600
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(paddingWidth, paddingWidth, paddingWidth, 0),
              child: Image.asset(
                'assets/images/logo.png',
                height: 150,
              )
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.fromLTRB(paddingWidth, paddingWidth, paddingWidth, 0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, Routes.login, arguments: TypeLogin(true, "User"));
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
                      "Customer",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(paddingWidth, paddingWidth, paddingWidth, 0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, Routes.login, arguments: TypeLogin(false, "Admin"));
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
                      "Organizer",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}