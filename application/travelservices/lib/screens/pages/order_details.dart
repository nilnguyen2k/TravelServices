import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/order_bloc/order_bloc.dart';
import 'package:travelservices/blocs/order_bloc/order_event.dart';
import 'package:travelservices/blocs/order_bloc/order_state.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/models/order_model.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/idarguments.dart';
import 'package:travelservices/screens/arguments/order_arguments.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OrderArguments args = ModalRoute.of(context)!.settings.arguments as OrderArguments;
    String url = args.items.first.url!; 
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Booking",
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(args.items.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Card(
                              elevation: 2,
                              child: Container(
                                padding: const EdgeInsets.only(right: 20),
                                width: double.infinity,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 20, top: 7),
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Change",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: hintText
                                          ),
                                        )
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Divider(thickness: 1),
                                    ),
                                    SizedBox(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    image: NetworkImage(url),
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
                                                  Text(
                                                    args.nameProduct,
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
                                                      args.description,
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
                                                      "${args.items.first.bookDay} ${args.items.first.bookTime}",
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
                                                      ticketAllType(args.items.first.tickets),
                                                      maxLines: 3,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.grey.shade500,
                                                        fontSize: 14
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ) 
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: TextFormField(
                                        autofocus: false,
                                        controller: noteController,
                                        decoration: InputDecoration(
                                          hintText: 'Note',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Divider(thickness: 1),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        "${totalValue(args.items.first.tickets)} VND",
                                        style: TextStyle(
                                          color: Colors.blue.shade600,
                                          fontSize: 22
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }) 
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 25,
                                  width: 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Customer information",
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                )
                              ],
                            ),
                            const Divider(thickness: 1),
                            const Text(
                              "Full name",
                              style: TextStyle(
                                fontSize: 18
                              ),  
                            ),
                            TextFormField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Full name of person booking tourism service"
                              ),
                            ),
                            const Divider(thickness: 1),
                            const Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 18
                              ),  
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email of person booking tourism service"
                              ),
                            ),
                            const Divider(thickness: 1),
                            const Text(
                              "Phone number",
                              style: TextStyle(
                                fontSize: 18
                              ),  
                            ),
                            const Divider(thickness: 1),
                            TextFormField(
                              controller: phoneController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone number of person booking tourism service"
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            BlocConsumer<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state.statusOrder == 1 || state.statusOrder == -1) {
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
                                state.statusOrder == 1 ? "assets/images/success.png" : "assets/images/failed.png",
                                height: 50,
                                width: 50,
                              ), 
                              const SizedBox(height: 20),
                              Text(
                                state.statusOrder == 1 ? "Booking tourism services were success" : "Booking tourism services were failed",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.productDetails, arguments: IdArguments(args.items.first.idService, false));
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
                }
              },
              builder:(context, state) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  width: double.infinity,
                  height: 80,            
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total\n${totalValue(args.items.first.tickets)} VND",
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      ElevatedButton(
                        onPressed: (){
                          OrderRequestModel model = OrderRequestModel(
                            infor: InforUserOrder(
                              email: emailController.text, 
                              fullname: nameController.text, 
                              phone: phoneController.text
                            ), 
                            statusOrder: true, 
                            items: setNote(args.items, noteController.text)
                          );
                          context.read<OrderBloc>().add(OrderSubmitEvent(orderData: model));
                        }, 
                        child: const SizedBox(
                          height: 50,
                          width: 100,
                          child: Center(
                            child: Text(
                              "Booking",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                              ),
                            ),
                          ),
                        )
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      )
    ); 
  }

  String ticketAllType(List<TicketsOrder> items) {
    String temp = "";

    for (int i = 0; i < items.length; i++) {
      temp = "$temp${items[i].typeTicket} x ${items[i].amountTicket}, ";
    }
    return temp.substring(0, temp.length - 2);
  }

  int totalValue(List<TicketsOrder> items) {
    int temp = 0;
    for (int i = 0; i < items.length; i++) {
      temp = temp + items[i].amountTicket*items[i].valueTicket;
    }
    return temp;
  }

  List<ItemsTicket> setNote(List<ItemsTicket> temps, String note) {
    List<ItemsTicket> tickets = temps;
    for (int i = 0; i < temps.length; i++) {
      tickets[i].note = note;
    }
    return tickets;
  }
  
}