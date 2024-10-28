import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/firebase_chat_model.dart';
import 'package:travelservices/repositories/chat_repositories.dart';
import 'package:travelservices/screens/arguments/chat_arguments.dart';

class ChatContentPage extends StatefulWidget {
  const ChatContentPage({Key? key}) : super(key: key);
  @override
  State<ChatContentPage> createState() => _ChatContentPageState();
}

class _ChatContentPageState extends State<ChatContentPage> {

  TextEditingController messageController = TextEditingController();
  late ChatArgument args;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context)!.settings.arguments as ChatArgument;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var args = ModalRoute.of(context)!.settings.arguments as ChatArgument;

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
              .collection("users")
              .doc(args.id2.toString())
              .snapshots(),
            builder:(context, snapshot) {
              if (snapshot.data != null) {
                return Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data?['avatar'] ?? avatarDefault),
                    ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameCustomer(snapshot.data?['firstname'], snapshot.data?['lastname']),
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black
                          ),
                        ),
                        Text(
                          snapshot.data?['status'] ? "Active" : "Inactive",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          )
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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                .collection("users")
                .doc(args.id1.toString())
                .collection("messages")
                .doc(args.id2.toString())
                .collection("chats")
                .orderBy('createDate', descending: false)
                .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      final Timestamp timestamp = snapshot.data?.docs[index]['createDate'] as Timestamp;
                      final DateTime dateTime = timestamp.toDate();
                      final dateString = DateFormat('K:mm').format(dateTime);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          alignment: snapshot.data?.docs[index]['sendById'] == args.id1 ? Alignment.centerRight : Alignment.centerLeft,
                          width: double.infinity,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: snapshot.data?.docs[index]['sendById'] == args.id1 ? 
                              const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)
                                ),
                              ) : const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)
                                ),
                              ),
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*2/3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data?.docs[index]['message']),
                                Text(dateString),
                              ],
                            ),
                          )
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: paddingWidth - 10),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey))
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: searchbar,
                        hintText: "Message",
                        hintStyle: const TextStyle(
                          color: hintText
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none
                        )
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (messageController.text.isNotEmpty) {
                        ChatRequestModel model = ChatRequestModel(
                          sendById: args.id1, 
                          sendToId: args.id2, 
                          createDate: DateTime.now(), 
                          modifiedDate: DateTime.now(), 
                          message: messageController.text, 
                          type: 'text'
                        );
                        ChatRepository.sendMessage(model);
                        messageController.clear();
                      }
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue.shade600,
                    )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String nameCustomer(String firstname, String lastname) {
    if (lastname.isEmpty) {
      if (firstname.isEmpty) {
        return "Customer";
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