import 'package:flutter/material.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/screens/widgets/manage_order_approved_widget.dart';
import 'package:travelservices/screens/widgets/manage_order_pending_widget.dart';

class OrderAdminPage extends StatefulWidget {
  const OrderAdminPage({Key? key}) : super(key: key);

  @override
  State<OrderAdminPage> createState() => _OrderAdminPageState();
}

class _OrderAdminPageState extends State<OrderAdminPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Booked",
              style: TextStyle(
                color: Colors.black
              ),
              textAlign: TextAlign.center,
            ),
            bottom: TabBar(
              labelColor: Colors.blue.shade600,
              indicatorColor: Colors.blue.shade600,
              padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
              tabs: [
                Tab(
                  text: 'Pending', 
                  icon: Icon(
                    Icons.hourglass_top,
                    color: Colors.blue.shade600,
                  )
                ),
                Tab(
                  text: 'Approved', 
                  icon: Icon(
                    Icons.check_box,
                    color: Colors.blue.shade600,
                  )
                )
              ],
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: const TabBarView(
            children: [
              ManageOrderPendingWidget(),
              ManageOrderApprovedWidget()
            ]
          )
        ),
      ),
    );   
  }
}