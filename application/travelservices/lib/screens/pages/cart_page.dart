import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/cart_bloc/cart_bloc.dart';
import 'package:travelservices/blocs/cart_bloc/cart_event.dart';
import 'package:travelservices/blocs/cart_bloc/cart_state.dart';
import 'package:travelservices/blocs/order_bloc/order_bloc.dart';
import 'package:travelservices/blocs/order_bloc/order_event.dart';
import 'package:travelservices/blocs/order_bloc/order_state.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/cart_model.dart';
import 'package:travelservices/models/infor_order_model.dart';
import 'package:travelservices/models/order_model.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/idarguments.dart';
import 'package:travelservices/screens/arguments/infor_order_arguments.dart';
import 'package:travelservices/screens/arguments/way_cart_arguments.dart';
import 'package:travelservices/screens/widgets/loading_widget.dart';
import 'package:travelservices/utils/convert_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<TextEditingController> notesController = List.generate(20, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    
    WayCartArguments args = ModalRoute.of(context)!.settings.arguments as WayCartArguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Cart",
            style: TextStyle(
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            onPressed: (){
              if (args.way) {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, Routes.productDetails, arguments: IdArguments(args.idService ?? 0, false));
              }
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
        body: BlocBuilder<CartBloc, CartState>(
          builder:(context, state) {
            if (state.getLoading) {
              return const LoadingWidget();
            } else {
              return Column(
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
                              children: List.generate(state.items.length, (index) {
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BlocBuilder<CartBloc, CartState>(
                                                buildWhen: (previous, current) {
                                                  return previous.statusClick != current.statusClick;
                                                },
                                                builder:(context, state) {
                                                  return Padding(
                                                    padding: const EdgeInsets.only(left: 5),
                                                    child: Checkbox(
                                                      activeColor: Colors.blue.shade600,
                                                      value: state.itemsChoose[index], 
                                                      onChanged: (value) {
                                                        context.read<CartBloc>().add(CartChooseItemEvent(index: index, status: value));
                                                      }
                                                    ),
                                                  );
                                                },
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      context.read<CartBloc>().add(CartDeleteEvent(idCartItem: state.items[index].idCartItem));
                                                    },
                                                    child: const Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.red
                                                      ),
                                                    )
                                                  ),
                                                  const SizedBox(width: 10),
                                                  GestureDetector(
                                                    onTap: (){
                                                      List<TicketInforOrder> list = [];
                                                      for (TicketCartResponse ticket in state.items[index].tickets) {
                                                        list.add(ConvertModel.convertToTicketInforOrder(ticket));
                                                      }                                                
                                                      Navigator.pushNamed(context, Routes.addToCart, arguments: InforOrderArgument(
                                                        description: '', 
                                                        idService: state.items[index].idService, 
                                                        nameProduct: state.items[index].name ?? "", 
                                                        status: false, 
                                                        way: false,
                                                        dayBook: state.items[index].bookDay,
                                                        timeBook: state.items[index].bookTime,
                                                        tickets: list,
                                                        idCartItem: state.items[index].idCartItem,
                                                        url: state.items[index].url
                                                      ));
                                                    },
                                                    child: const Text(
                                                      "Change",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: hintText
                                                      ),
                                                    )
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Divider(thickness: 1),
                                          ),
                                          SizedBox(
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
                                                          image: NetworkImage(state.items[index].url ?? productImgDefault),
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
                                                          state.items[index].name ?? "",
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
                                                            state.items[index].description ?? "",
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
                                                            "${state.items[index].bookDay} ${state.items[index].bookTime}",
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
                                                            ticketAllType(state.items[index].tickets),
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
                                          const SizedBox(height: 5),
                                          Container(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: TextFormField(
                                              controller: notesController[index],
                                              autofocus: false,
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
                                              "${totalValue(state.items[index].tickets)} VND",
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
                  Container(
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
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: BlocConsumer<OrderBloc, OrderState>(
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
                                          if (args.way) {
                                            Navigator.pop(context);
                                            context.read<CartBloc>().add(CartReadEvent());
                                          } else {
                                            Navigator.pushNamed(context, Routes.productDetails, arguments: IdArguments(args.idService ?? 0, false));
                                            context.read<CartBloc>().add(CartReadEvent());
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
                        }
                      },
                      builder:(context, stateO) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total\n${totalOrder(state.itemsChoose, state.items)} VND",
                              style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            ElevatedButton(
                              onPressed: (){
                                List<bool> itemsChoose = state.itemsChoose;
                                List<ItemsTicket> items = [];
                                for (int i = 0; i < itemsChoose.length; i++) {
                                  if (itemsChoose[i]) {
                                    List<TicketsOrder> tickets = [];
                                    for (TicketCartResponse response in state.items[i].tickets) {
                                      tickets.add(ConvertModel.convertToTicketOrder(response));
                                    }
                                    items.add(ItemsTicket(
                                      idCartItem: state.items[i].idCartItem, 
                                      idService: state.items[i].idService, 
                                      bookDay: state.items[i].bookDay ?? "", 
                                      bookTime: state.items[i].bookTime ?? "", 
                                      note: notesController[i].text, 
                                      tickets: tickets, 
                                      name: state.items[i].name, 
                                      description: state.items[i].description, 
                                      url: state.items[i].url
                                    ));
                                  }
                                }

                                OrderRequestModel model = OrderRequestModel(
                                  infor: InforUserOrder(
                                    fullname: nameController.text, 
                                    email: emailController.text,
                                    phone: phoneController.text
                                  ), 
                                  statusOrder: false, 
                                  items: items
                                );

                                context.read<OrderBloc>().add(OrderSubmitEvent(orderData: model));

                              }, 
                              child: SizedBox(
                                height: 50,
                                width: 100,
                                child: Center(
                                  child: Text(
                                    "Booking ${state.itemsChoose.where((element) => element == true).isEmpty ? "" : "(${state.itemsChoose.where((element) => element == true).length})"}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16
                                    ),
                                  ),
                                ),
                              )
                            )
                          ],
                        );
                      },
                    )
                  )

                ],
              );
            }   
          },
        )
      )
    );   
  }

  String ticketAllType(List<TicketCartResponse> items) {

    String temp = "";

    for (int i = 0; i < items.length; i++) {
      temp = "$temp${items[i].typeTicket} x ${items[i].amountTicket}, ";
    }
    return temp.substring(0, temp.length - 2);
  }

  int totalValue(List<TicketCartResponse> items) {
    int temp = 0;
    for (int i = 0; i < items.length; i++) {
      temp = temp + items[i].amountTicket!*items[i].valueTicket!;
    }
    return temp;
  }

  int totalOrder(List<bool> itemsChoose, List<CartResponseModel> items) {
    int total = 0;
    for (int i = 0; i < items.length; i++) {
      if (itemsChoose[i]) {
        total = total + totalValue(items[i].tickets);
      }
    }
    return total;
  }


}