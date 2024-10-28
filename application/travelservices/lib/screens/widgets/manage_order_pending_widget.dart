import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/admin_order_bloc/admin_order_bloc.dart';
import 'package:travelservices/blocs/admin_order_bloc/admin_order_event.dart';
import 'package:travelservices/blocs/admin_order_bloc/admin_order_state.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/order_model.dart';
import 'package:travelservices/screens/widgets/loading_widget.dart';


class ManageOrderPendingWidget extends StatefulWidget {
  const ManageOrderPendingWidget({Key? key}) : super(key: key);

  @override
  State<ManageOrderPendingWidget> createState() => _ManageOrderPendingWidgetState();
}

class _ManageOrderPendingWidgetState extends State<ManageOrderPendingWidget> {
  @override
  Widget build(BuildContext context) {
    AdminOrderBloc bloc = context.read<AdminOrderBloc>();
    bloc.add(AdminOrderReadByPendingEvent());
    return BlocBuilder<AdminOrderBloc, AdminOrderState>(
      bloc: bloc,
      builder:(context, state) {
        if (state.statusReadPending) {
          return const LoadingWidget();
        }
        return SizedBox(
          child: ListView.builder(
            itemCount: state.ordersByPending.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 10),
                child: Card(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    height: 110,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(state.ordersByPending[index].url),
                                        fit: BoxFit.fitHeight,
                                        alignment: Alignment.topCenter,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    "#${state.ordersByPending[index].id.toString()}",
                                    style: TextStyle(
                                      color: Colors.blue.shade600
                                    ),
                                  ),
                                )
                              ],
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
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              "assets/images/information.png",
                                                              height: 50,
                                                              width: 50,
                                                            ),
                                                            const SizedBox(width: 15),
                                                            const Text(
                                                              "Information",
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(height: 20),
                                                        Container(
                                                          margin: const EdgeInsets.only(top: 5),
                                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                                          child: Text(
                                                            "Fullname: ${state.ordersByPending[index].infor.fullname}",
                                                            style: const TextStyle(
                                                              fontSize: 16,
                                                              fontStyle: FontStyle.italic
                                                            ),
                                                          )
                                                        ),
                                                        Container(
                                                          margin: const EdgeInsets.only(top: 5),
                                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                                          child: Text(
                                                            "Email: ${state.ordersByPending[index].infor.email}",
                                                            style: const TextStyle(
                                                              fontSize: 16,
                                                              fontStyle: FontStyle.italic
                                                            ),
                                                          )
                                                        ),
                                                        Container(
                                                          margin: const EdgeInsets.only(top: 5),
                                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                                          child: Text(
                                                            "Phone: ${state.ordersByPending[index].infor.phone}",
                                                            style: const TextStyle(
                                                              fontSize: 16,
                                                              fontStyle: FontStyle.italic
                                                            ),
                                                          )
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                            );
                                          },
                                          child: Text(
                                            "Information",
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.green.shade600
                                            ),  
                                          ),
                                        ),
                                        const SizedBox(width: 7),
                                        InkWell(
                                          onTap: (){
                                            context.read<AdminOrderBloc>().add(AdminOrderApprovedEvent(idOrderItem: state.ordersByPending[index].id, status: 'approved'));
                                            // showDialog(
                                            //   context: context, 
                                            //   builder: (context) {
                                            //     return Dialog(
                                            //       shape: RoundedRectangleBorder(
                                            //         borderRadius: BorderRadius.circular(15)
                                            //       ),
                                            //       child: SizedBox(
                                            //         height: 300,
                                            //         child: Column(
                                            //           mainAxisAlignment: MainAxisAlignment.center,
                                            //           children: [
                                            //             Row(
                                            //               mainAxisAlignment: MainAxisAlignment.center,
                                            //               children: [
                                            //                 Image.asset(
                                            //                   "assets/images/verified.png",
                                            //                   height: 50,
                                            //                   width: 50,
                                            //                 ),
                                            //                 const SizedBox(width: 15),
                                            //                 const Text(
                                            //                   "Approve",
                                            //                   style: TextStyle(
                                            //                     fontSize: 20,
                                            //                     fontWeight: FontWeight.bold
                                            //                   ),
                                            //               )
                                            //               ],
                                            //             ),
                                            //             const SizedBox(height: 50),
                                            //             Container(
                                            //               padding: const EdgeInsets.symmetric(horizontal: 20),
                                            //               child: const TextField(
                                            //                 decoration: InputDecoration(
                                            //                   border: OutlineInputBorder()
                                            //                 ),
                                            //               ),
                                            //             ),
                                            //             Container(
                                            //               margin: const EdgeInsets.only(top: 20),
                                            //               padding: const EdgeInsets.symmetric(horizontal: 20),
                                            //               width: double.infinity,
                                            //               height: 55,
                                            //               child: ElevatedButton(
                                            //                 onPressed: (){},
                                            //                 child: const Text("Submit"),
                                            //               )
                                            //             )
                                            //           ],
                                            //         ),
                                            //       ),
                                            //     );
                                            //   }
                                            // );
                                          },
                                          child: Text(
                                            "Approve",
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.blue.shade600
                                            ),
                                          )
                                        ),
                                        const SizedBox(width: 7),
                                        InkWell(
                                          onTap: (){
                                            context.read<AdminOrderBloc>().add(AdminOrderCancelEvent(idOrderItem: state.ordersByPending[index].id, status: 'deleted'));
                                          },
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.red.shade600
                                            ),  
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      state.ordersByPending[index].nameService,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "${state.ordersByPending[index].bookDay} ${state.ordersByPending[index].bookTime}",
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
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: ticketAllType(state.ordersByPending[index].tickets),
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 14
                                            ),
                                          ),
                                          TextSpan(
                                            text: " Details",
                                            style: TextStyle(
                                              color: Colors.green.shade500,
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic
                                            ),
                                            recognizer: TapGestureRecognizer()..onTap = () {
                                              showDialog(
                                                context: context, 
                                                builder: (context) {
                                                  return Dialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15)
                                                    ),
                                                    child: ConstrainedBox(
                                                      constraints: const BoxConstraints(
                                                        minHeight: 200,
                                                        maxHeight: 500,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Image.asset(
                                                                "assets/images/tickets.png",
                                                                height: 50,
                                                                width: 50,
                                                              ),
                                                              const SizedBox(width: 15),
                                                              const Text(
                                                                "Ticket Details",
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.bold
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(height: 20),
                                                          Column(
                                                            children: List.generate(state.ordersByPending[index].tickets.length, (i) {
                                                              return SizedBox(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Container(
                                                                      width: double.infinity,
                                                                      alignment: Alignment.center,
                                                                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                      child: Text(
                                                                        "Ticket ${index + 1}",
                                                                        style: const TextStyle(
                                                                          fontSize: 16,
                                                                          fontStyle: FontStyle.italic,
                                                                          fontWeight: FontWeight.bold
                                                                        ),
                                                                      )
                                                                    ),
                                                                    Container(
                                                                      margin: const EdgeInsets.only(top: 5),
                                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                      child: Text(
                                                                        "Type: ${state.ordersByPending[index].tickets[i].typeTicket}",
                                                                        style: const TextStyle(
                                                                          fontSize: 16,
                                                                          fontStyle: FontStyle.italic
                                                                        ),
                                                                      )
                                                                    ),
                                                                    Container(
                                                                      margin: const EdgeInsets.only(top: 5),
                                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                      child: Text(
                                                                        "Value: ${state.ordersByPending[index].tickets[i].valueTicket} VND",
                                                                        style: const TextStyle(
                                                                          fontSize: 16,
                                                                          fontStyle: FontStyle.italic
                                                                        ),
                                                                      )
                                                                    ),
                                                                    Container(
                                                                      margin: const EdgeInsets.only(top: 5),
                                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                      child: Text(
                                                                        "Amount: ${state.ordersByPending[index].tickets[i].amountTicket}",
                                                                        style: const TextStyle(
                                                                          fontSize: 16,
                                                                          fontStyle: FontStyle.italic
                                                                        ),
                                                                      )
                                                                    ),
                                                                    Container(
                                                                      margin: const EdgeInsets.only(top: 5),
                                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                      child: Text(
                                                                        "Note: ${state.ordersByPending[index].tickets[i].note}",
                                                                        style: const TextStyle(
                                                                          fontSize: 16,
                                                                          fontStyle: FontStyle.italic
                                                                        ),
                                                                      )
                                                                    ),
                                                                  ],
                                                                )
                                                              );
                                                            }),
                                                          )
                                                          
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                              );
                                            } 
                                          ),
                                        ],
                                      ),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ),
                                  Container(
                                    width: double.infinity,
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Total: ${state.ordersByPending[index].total} VND",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.orange.shade500,
                                          fontSize: 17,
                                          fontStyle: FontStyle.italic
                                        ),
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
                  ),
                ),
              );
            },
          )
        ); 
      },
    ); 
  }


  String ticketAllType(List<TicketsOrder> items) {
    String temp = "";

    for (int i = 0; i < items.length; i++) {
      temp = "$temp${items[i].typeTicket} x ${items[i].amountTicket}, ";
    }
    return temp.substring(0, temp.length - 2);
  }
}