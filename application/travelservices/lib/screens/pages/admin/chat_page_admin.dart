import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/chat_arguments.dart';
import 'package:travelservices/screens/widgets/loading_widget.dart';
import 'package:travelservices/utils/shared_preferences.dart';

class ChatPageAdmin extends StatefulWidget {
  const ChatPageAdmin({Key? key}) : super(key: key);

  @override
  State<ChatPageAdmin> createState() => _ChatPageAdminState();
}



class _ChatPageAdminState extends State<ChatPageAdmin> {


  Future<Map<String, dynamic>> sharedPreValue() async {
    return {
      "idAuth" : await SharedPreferencesCustom.getIntCustom('idAuth'),
      "username" : await SharedPreferencesCustom.getStringCustom('username')
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Contacts",
          style: TextStyle(
            color: Colors.black
          ),
          textAlign: TextAlign.center,
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
        future: sharedPreValue(),
        builder: (context, AsyncSnapshot<dynamic> snapshotshare) {
          if (snapshotshare.hasData) {
            return Column(
              children: [
                const SizedBox(height: 5),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(snapshotshare.data['idAuth'].toString())
                        .collection('messages')
                        .snapshots(),
                      builder:(context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text("No Chats Available"),
                            );
                          } else {
                            return Column(
                              children: List.generate(snapshot.data!.docs.length, (index) {
                                var friendId = snapshot.data!.docs[index].id;
                                var lastMsg = snapshot.data!.docs[index]['last_msg'];
                                return FutureBuilder(
                                  future: FirebaseFirestore.instance.collection('users').doc(friendId).get(),
                                  builder:(context, asyncSnapshot) {
                                    if (asyncSnapshot.hasData) {
                                      var friend = asyncSnapshot.data as DocumentSnapshot;
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context, Routes.chatContentPage, arguments: ChatArgument(
                                            id1: snapshotshare.data['idAuth'],
                                            id2: int.parse(friendId)
                                          ));
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage: NetworkImage(friend['avatar'].isEmpty ? avatarDefault : friend['avatar']),
                                                      radius: 35,
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              // friend['firstname'].isEmpty ? "Guest" : friend['firstname'],
                                                              getNameChat(friend['firstname'], friend['lastname']), 
                                                              style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold
                                                              ),
                                                            ),
                                                            const SizedBox(height: 5),
                                                            Text(
                                                              lastMsg,
                                                              style: const TextStyle(
                                                                fontSize: 17
                                                              ),
                                                            ),       
                                                          ],
                                                        ),
                                                      ),
                                                    ),                           
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Divider(thickness: 2)
                                          ],
                                        ),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                );
                              }),
                            );
                          }
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    )
                  ),
                )
              ],
            );
          } else {
            return const LoadingWidget();
          }
        },
      )
    );
  }
  
  String getNameChat(String firstname, String lastname) {
    if (firstname.isEmpty) {
      if (lastname.isEmpty) {
        return "Customer";
      } else {
        return lastname;
      }
    } else {
      if (lastname.isEmpty) {
        return firstname;
      } else {
        return "$firstname $lastname";
      }
    }
  }
}