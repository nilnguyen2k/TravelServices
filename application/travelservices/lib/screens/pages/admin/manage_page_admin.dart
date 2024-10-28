import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_bloc.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_event.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_state.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/product_admin_model.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/action_product_by_admin.dart';

class ManagePageAdmin extends StatefulWidget {
  const ManagePageAdmin({Key? key}) : super(key: key);

  @override
  State<ManagePageAdmin> createState() => _ManagePageAdminState();
}

class _ManagePageAdminState extends State<ManagePageAdmin> {
  @override
  Widget build(BuildContext context) {

    AdminProductBloc bloc = context.read<AdminProductBloc>();
    bloc.add(AdminReadListProductEvent());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "Home",
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 10),
              child: Container(
                height: 70,
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.createProductAdmin, arguments: ActionProductByAdmin(status: true));
                    },
                    child: const Text("New tourism service"),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 10),
              child: Text(
                "Tourism services",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
                ),
              ),
            ),
            Expanded(
              child: BlocConsumer<AdminProductBloc, AdminProductState>(
                listener: (context, state) {
                  if (state.getProductDetails) {
                    Navigator.pushNamed(context, Routes.createProductAdmin, arguments: ActionProductByAdmin(productDetails: state.readProduct, status: false));
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.listProduct.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                        child: SizedBox(
                          child: Card(
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Container(
                                          height: 110,
                                          width: 110,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(state.listProduct[index].galleries.isEmpty ? productImgDefault :  state.listProduct[index].galleries[0].url),
                                              fit: BoxFit.fitHeight,
                                              alignment: Alignment.topCenter,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      context.read<AdminProductBloc>().add(AdminProductDetailsEvent(idService: state.listProduct[index].service.idService));
                                                    },
                                                    child: Text(
                                                      "Update",
                                                      style: TextStyle(
                                                        fontStyle: FontStyle.italic,
                                                        color: Colors.blue.shade600
                                                      ),
                                                    )
                                                  ),          
                                                ],
                                              ),
                                            ),
                                            Text(
                                              state.listProduct[index].service.name,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 17
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Text(
                                                state.listProduct[index].service.description,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 14
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Text(
                                                "Area: ${state.listProduct[index].service.area}",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 14
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Text(
                                                "Category: ${state.listProduct[index].service.category}",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 14
                                                ),
                                              ),
                                            ),
                                            state.listProduct[index].ticket.isNotEmpty ? Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Text(
                                                "Tickets: ${tickets(state.listProduct[index].ticket)}",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 14
                                                ),
                                              ),
                                            ) : const SizedBox.shrink(),
                                            state.listProduct[index].schedule.isNotEmpty ? Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Text(
                                                "Schedule: ${schedules(state.listProduct[index].schedule)}",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 14
                                                ),
                                              ),
                                            ) : const SizedBox.shrink(),
                                          ],
                                        ),
                                      ) 
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  );
                },
              )
            )
            // BlocConsumer<AdminProductBloc, AdminProductState>(
            //   listener: (context, state) {
            //     if (state.getProductDetails) {
            //       Navigator.pushNamed(context, Routes.createProductAdmin, arguments: ActionProductByAdmin(productDetails: state.readProduct, status: false));
            //     }
            //   },
            //   builder:(context, state) {
            //     return TextButton(
            //       onPressed: (){
            //         context.read<AdminProductBloc>().add(AdminProductDetailsEvent(idService: 8));
            //       }, 
            //       child: Text("Update")
            //     );
            //   },
            // )
          ],
        )
      )
    );   
  }


  String tickets(List<TicketProductDetails> tickets) {
    String temp = "";
    if (tickets.isNotEmpty) {
      for (TicketProductDetails item in tickets) {
        temp = "$temp${item.typeTicket}, ";
      }
      return temp.substring(0, temp.length - 2);
    } else {
      return temp;
    }
  }

  String schedules(List<ScheduleDetails> schedules) {
    String temp = "";
    if (schedules.isNotEmpty) {
      for (ScheduleDetails item in schedules) {
        temp = "$temp${item.time}, ";
      }
      return temp.substring(0, temp.length - 2);
    } else {
      return temp;
    }
  }


}