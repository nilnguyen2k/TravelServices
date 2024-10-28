import 'package:flutter/material.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/untils_model.dart';
import 'package:travelservices/screens/widgets/loading_widget.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {

  late Future<AboutAppModel> aboutApp;

  @override
  void initState() {
    aboutApp = getInforApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "About Application",
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
        body: FutureBuilder(
          future: aboutApp,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data as AboutAppModel;
              return SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(paddingWidth),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width*2/5,
                            width: MediaQuery.of(context).size.width*2/5,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 8,
                              color: Colors.grey.shade200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Organizer",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.blue.shade600
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    data.numAdmin.toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width*2/5,
                            width: MediaQuery.of(context).size.width*2/5,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 8,
                              color: Colors.grey.shade200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Customer",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.blue.shade600
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    data.numUser.toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(paddingWidth),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width*2/5,
                            width: MediaQuery.of(context).size.width*2/5,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 8,
                              color: Colors.grey.shade200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Orders",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.blue.shade600
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    data.numOrder.toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width*2/5,
                            width: MediaQuery.of(context).size.width*2/5,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 8,
                              color: Colors.grey.shade200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Services",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.blue.shade600
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    data.numService.toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              );
            } else {
              return const LoadingWidget();
            }
          },
        )
      )
    );   
  }

  Future<AboutAppModel> getInforApp() async {
    Api api = Api();
    var object = await api.getRequest(Api.url, "public/about");
    return AboutAppModel.fromJson(object.data);
  }
}