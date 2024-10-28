
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/screens/pages/admin/chat_page_admin.dart';
import 'package:travelservices/screens/pages/admin/manage_page_admin.dart';
import 'package:travelservices/screens/pages/admin/order_admin.dart';
import 'package:travelservices/screens/pages/profile_page.dart';

class RoutePageAdmin extends StatefulWidget {
  const RoutePageAdmin({Key? key}) : super(key: key);

  @override
  State<RoutePageAdmin> createState() => _RoutePageAdminState();
}

class _RoutePageAdminState extends State<RoutePageAdmin> {

  final List<Widget> pages = const [
    ManagePageAdmin(),
    ChatPageAdmin(),
    OrderAdminPage(),
    ProfilePage(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: pages, 
      ), 
      bottomNavigationBar: Container(
        color: bgbottombar, 
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: GNav(
          onTabChange: (value) async {
            setState(() {
              index = value;
            });
          },
          tabBorderRadius: 20,
          padding: const EdgeInsets.all(12),
          color: Colors.grey.shade400,
          activeColor: Colors.white,
          tabBackgroundGradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue.shade100,
                Colors.blue.shade600,
              ],),
          gap: 8,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.chat,
              text: 'Chat',
            ),
            GButton(
              icon: Icons.list_alt,
              text: 'Booked',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ]
        ),
      ),
    ); 
  }
}