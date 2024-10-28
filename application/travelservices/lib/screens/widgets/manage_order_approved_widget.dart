import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/admin_order_bloc/admin_order_bloc.dart';
import 'package:travelservices/blocs/admin_order_bloc/admin_order_event.dart';
import 'package:travelservices/blocs/admin_order_bloc/admin_order_state.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/order_model.dart';
import 'package:travelservices/screens/widgets/loading_widget.dart';


class ManageOrderApprovedWidget extends StatefulWidget {
  const ManageOrderApprovedWidget({Key? key}) : super(key: key);

  @override
  State<ManageOrderApprovedWidget> createState() => _ManageOrderApprovedWidgetState();
}

class _ManageOrderApprovedWidgetState extends State<ManageOrderApprovedWidget> {
  @override
  Widget build(BuildContext context) {
    AdminOrderBloc bloc = context.read<AdminOrderBloc>();
    bloc.add(AdminOrderReadByApprovedEvent());
    return BlocBuilder<AdminOrderBloc, AdminOrderState>(
      bloc: bloc,
      builder:(context, state) {
        if (state.statusReadApproved) {
          return const LoadingWidget();
        }
        return SizedBox(
          child: ListView.builder(
            itemCount: state.ordersByApproved.length,
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
                                        image: NetworkImage(state.ordersByApproved[index].url),
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
                                    "#${state.ordersByApproved[index].id.toString()}",
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
                                                            "Fullname: ${state.ordersByApproved[index].infor.fullname}",
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
                                                            "Email: ${state.ordersByApproved[index].infor.email}",
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
                                                            "Phone: ${state.ordersByApproved[index].infor.phone}",
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
                                            context.read<AdminOrderBloc>().add(AdminOrderExperienceEvent(idOrderItem: state.ordersByApproved[index].id, status: 'experienced'));
                                          },
                                          child: Text(
                                            "Experienced",
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.blue.shade600
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      state.ordersByApproved[index].nameService,
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
                                      "${state.ordersByApproved[index].bookDay} ${state.ordersByApproved[index].bookTime}",
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
                                            text: ticketAllType(state.ordersByApproved[index].tickets),
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
                                                            children: List.generate(state.ordersByApproved[index].tickets.length, (i) {
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
                                                                        "Type: ${state.ordersByApproved[index].tickets[i].typeTicket}",
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
                                                                        "Value: ${state.ordersByApproved[index].tickets[i].valueTicket} VND",
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
                                                                        "Amount: ${state.ordersByApproved[index].tickets[i].amountTicket}",
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
                                                                        "Note: ${state.ordersByApproved[index].tickets[i].note}",
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
                                        "Total: ${state.ordersByApproved[index].total} VND",
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