import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travelservices/blocs/cart_bloc/cart_bloc.dart';
import 'package:travelservices/blocs/cart_bloc/cart_event.dart';
import 'package:travelservices/blocs/cart_bloc/cart_state.dart';
import 'package:travelservices/blocs/infor_order_bloc/infor_order_bloc.dart';
import 'package:travelservices/blocs/infor_order_bloc/infor_order_event.dart';
import 'package:travelservices/blocs/infor_order_bloc/infor_order_state.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/cart_model.dart';
import 'package:travelservices/models/infor_order_model.dart';
import 'package:travelservices/models/order_model.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/infor_order_arguments.dart';
import 'package:travelservices/screens/arguments/order_arguments.dart';
import 'package:travelservices/screens/arguments/way_cart_arguments.dart';
import 'package:travelservices/utils/convert_model.dart';
import 'package:travelservices/utils/totalValueOrder.dart';

class AddToCartPage extends StatefulWidget {
  const AddToCartPage({Key? key}) : super(key: key);

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {

  DateTime focusDay = DateTime.now();
  
  bool status = false;
  bool way = false;

  late int idService;
  late int idCartItem;
  late String nameProduct;
  late String description;
  late String url;
  late String dayBook;
  late String timeBook;
  late List<TicketInforOrder>? tickets;


  InforOrderBloc bloc = InforOrderBloc();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        InforOrderArgument args = ModalRoute.of(context)!.settings.arguments as InforOrderArgument;
        idService = args.idService;
        status = args.status;
        nameProduct = args.nameProduct;
        description = args.description;
        url = args.url ?? "";
        way = args.way;
        
        if (!way) {
          
          timeBook = args.timeBook!;
          tickets = args.tickets;
          idCartItem = args.idCartItem ?? 0;

          List<int> count = List.generate(10, (index) => 0);
          for (int i = 0; i < tickets!.length; i++) {
            count[i] = tickets![i].amountTicket;
          }
          bloc.add(InforOrderReadCalendarEvent(
            idService: idService, 
            focusDay: DateTime.parse(args.dayBook!), 
            selectDay: DateTime.parse(args.dayBook!), 
            count: count,
            schedule: timeBook, 
            total: TotalValueOrder.totalValue(tickets!, count)
          ));
          focusDay = DateTime.parse(args.dayBook!);
        } else {
          bloc.add(InforOrderReadCalendarEvent(
            idService: idService, 
            focusDay: DateTime.now(), 
            selectDay: DateTime.now(),
            count: List.generate(10, (index) => 0),
            schedule: "", 
            total: 0
          ));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue.shade600,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "Select",
            style: TextStyle(
              color: Colors.black
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder<InforOrderBloc, InforOrderState>(
                      bloc: bloc,
                      builder:(context, state) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.grey.shade200, style: BorderStyle.solid)
                          ),
                          child: TableCalendar(
                            focusedDay: focusDay, 
                            firstDay: DateTime.now(),  
                            lastDay: DateTime.utc(2030, 3, 14), 
                            selectedDayPredicate: (day) {
                              return isSameDay(state.selectDay, day);
                            },
                            
                            onDaySelected: (selectedDay, focusedDay) {     
                              bloc.add(InforOrderSelectDayEvent(
                                focusDay: focusedDay, 
                                selectDay: selectedDay,
                                idService: idService
                              ));
                            },
                            onPageChanged: (focusedDay) {
                              focusDay = focusedDay;
                            },
                            calendarBuilders: CalendarBuilders(
                              markerBuilder: (context, day, events) {
                                return countEvent(day, state.events) > 0 ? Container(
                                  width: 20,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Center(
                                    child: Text(
                                      countEvent(day, state.events).toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ) : Container();
                              },
                            ),
                            calendarStyle: CalendarStyle(
                              isTodayHighlighted: true,
                              outsideDaysVisible: false,
                              selectedDecoration: BoxDecoration(
                                color: Colors.blue.shade600,
                                shape: BoxShape.rectangle,
                              ),
                              selectedTextStyle: const TextStyle(color: Colors.white),
                              todayDecoration: const BoxDecoration(
                                color: Colors.purpleAccent,
                                shape: BoxShape.rectangle,
                              ),
                            ), 
                            headerStyle: HeaderStyle(
                              titleCentered: true,
                              formatButtonVisible: false,
                              titleTextStyle: const TextStyle(
                                fontSize: 20
                              ),
                              formatButtonDecoration: BoxDecoration(
                                color: Colors.blue.shade600,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              formatButtonTextStyle: const TextStyle(
                                color: Colors.white
                              ),
                              leftChevronVisible: false,
                              rightChevronVisible: false,
                              headerPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15)
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<InforOrderBloc, InforOrderState>(
                      bloc: bloc,
                      builder:(context, state) {
                        List<EventCalender> eventsCalendar = getEventCalendar(state.selectDay, state.events);
                        return eventsCalendar.isEmpty ? 
                          const SizedBox.shrink() :
                          Column(
                            children: List.generate(eventsCalendar.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(paddingWidth, 10, paddingWidth, 0),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.blue.shade600,
                                    )
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Event: ${eventsCalendar[index].service}",
                                        style: const TextStyle(
                                          fontSize: 15
                                        ),
                                      ),
                                      eventsCalendar[index].bookTime.isEmpty ? const SizedBox.shrink() : Text(
                                        "Time: ${eventsCalendar[index].bookTime}",
                                        style: const TextStyle(
                                          fontSize: 14
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                          );
                      },
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<InforOrderBloc, InforOrderState>(
                      bloc: bloc,
                      builder:(context, state) {
                        InforOrder data = state.rangeOrderService;
                        if (state.haveSchedule) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.grey.shade200, style: BorderStyle.solid)
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 4,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.blue.shade600,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            "Schedule",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 10),
                                  child: Column(
                                    children: [
                                      // const SizedBox(
                                      //   width: double.infinity,
                                      //   child: Text(
                                      //     "Time: ",
                                      //     style: TextStyle(
                                      //         fontSize: 18,
                                      //         fontWeight: FontWeight.bold
                                      //       ),
                                      //   ),
                                      // ),
                                      // const SizedBox(height: 10),
                                      Row(
                                        children: List.generate(data.schedules.length, (index) {
                                          if (data.schedules[index].quantityPerDay == 0) {
                                            return Padding(
                                              padding: const EdgeInsets.only(right: 8),
                                              child: Container(
                                                height: 40,
                                                width: 60,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Text(data.schedules[index].time),
                                              ),
                                            );
                                          } else {
                                            return Padding(
                                              padding: const EdgeInsets.only(right: 8),
                                              child: Container(
                                                height: 40,
                                                width: 60,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: state.schedule == data.schedules[index].time ? Colors.blue.shade600 : Colors.green,
                                                  borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: GestureDetector(
                                                  onTap: (){
                                                    bloc.add(InforOrderScheduleEvent(schedule: data.schedules[index].time));
                                                  },
                                                  child: Text(data.schedules[index].time)
                                                ),
                                              ),
                                            );
                                          } 
                                        })
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ); 
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<InforOrderBloc, InforOrderState>(
                      bloc: bloc,
                      buildWhen: (previous, current) {
                        return previous.statusTicket != current.statusTicket;
                      },
                      builder:(context, state) {
                        InforOrder data = state.rangeOrderService;
                        if (state.haveTicket) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.grey.shade200, style: BorderStyle.solid)
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 4,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.blue.shade600,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            "Tickets",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(thickness: 1),   
                                Column(
                                  children: List.generate(data.tickets.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 10),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 10),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          data.tickets[index].typeTicket,
                                                          style: const TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black
                                                          ),
                                                        ),
                                                        const SizedBox(height: 5),
                                                        Text(
                                                          "${data.tickets[index].valueTicket} VND",
                                                          style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black
                                                          ),
                                                        ),
                                                        const SizedBox(height: 5),
                                                        Text(
                                                          data.tickets[index].note ?? "",
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 30,
                                                        width: 30,
                                                        color: Colors.blue.shade600,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            bloc.add(InforOrderValueTicketEvent(
                                                              index: index, 
                                                              status: false,
                                                            ));
                                                          },
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50,
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          state.counts[index].toString(),
                                                          style: const TextStyle(
                                                            fontSize: 18
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 30,
                                                        width: 30,
                                                        color: Colors.blue.shade600,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            bloc.add(InforOrderValueTicketEvent(
                                                              index: index, 
                                                              status: true,
                                                            ));
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Divider(thickness: 1), 
                                        ],
                                      ),
                                    );
                                  })
                                )
                              ]
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),   
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<InforOrderBloc, InforOrderState>(
                    bloc: bloc,
                    builder:(context, state) {
                      return Text(
                        "Total\n${state.total} VND",
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.start,
                      );
                    },
                  ),
                  status ? BlocBuilder<InforOrderBloc, InforOrderState>(
                    bloc: bloc,
                    builder:(context, state) {
                      return ElevatedButton(
                        onPressed: (){
                          // Order
                          // Declare
                          List<TicketsOrder> tickets = [];
                          List<TicketInforOrder> temps = state.rangeOrderService.tickets;
                          for(int i = 0; i < temps.length; i++) {
                            if (state.counts[i] != 0) {
                              tickets.add(TicketsOrder(
                              idTicket: temps[i].idTicket, 
                              valueTicket: temps[i].valueTicket, 
                              typeTicket: temps[i].typeTicket, 
                              amountTicket: state.counts[i], 
                              note: temps[i].note ?? ""
                              ));
                            }
                          } 
                          List<ItemsTicket> itemsTicket = [
                            ItemsTicket(
                              idCartItem: 0, 
                              idService: idService, 
                              bookDay: "${state.focusDay.year}-${state.focusDay.month}-${state.focusDay.day}", 
                              bookTime: state.schedule, 
                              note: "", 
                              tickets: tickets, 
                              description: description, 
                              name: nameProduct, 
                              url: url
                            )
                          ];
                          print("1: ${url}");
                          Navigator.pushNamed(context, Routes.orderDetails, arguments: OrderArguments(
                            statusOrder: true, 
                            items: itemsTicket, 
                            nameProduct: nameProduct, 
                            description: description, 
                          ));
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
                      ); 
                    }
                  ) : BlocBuilder<InforOrderBloc, InforOrderState>(
                    bloc: bloc,
                    builder:(context, stateC) {
                      return BlocConsumer<CartBloc, CartState>(
                        listener: (context, state) {
                          if (state.statusProccess == 1) {
                            Navigator.pushNamed(context, Routes.cartPage, arguments: WayCartArguments(way: false, idService: idService));
                          }
                          if (state.statusProccess == -1) {
                            MotionToast.error(
                              height: 60,
                              title: const Text(
                                "Failed",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              description: const Text("Someting was wrong")
                            ).show(context);
                          }
                        },
                        builder:(context, state) {
                          return ElevatedButton(
                            onPressed: () {                  
                              // Cart
                              // Declare
                              List<TicketCartRequest> ticketsRequest = [];

                              for (int i = 0; i < stateC.counts.length; i++) {
                                if (stateC.counts[i] != 0) {
                                  List<TicketInforOrder> temps = stateC.rangeOrderService.tickets;
                                  TicketInforOrder ticket = TicketInforOrder(
                                    idTicket: temps[i].idTicket, 
                                    valueTicket: temps[i].valueTicket, 
                                    typeTicket: temps[i].typeTicket, 
                                    amountTicket: stateC.counts[i], 
                                    note: temps[i].note
                                  );
                                  ticketsRequest.add(ConvertModel.convertToTicketCartRequest(ticket));
                                }
                              }
                              NumberFormat formatter = NumberFormat("00");
                              CartRequestModel model = CartRequestModel(
                                idService: idService, 
                                name: nameProduct, 
                                url: url, 
                                description: description, 
                                bookDay: "${stateC.focusDay.year}-${formatter.format(stateC.focusDay.month)}-${formatter.format(stateC.focusDay.day)}", 
                                bookTime: stateC.schedule, 
                                tickets: ticketsRequest
                              ); 
                              if (!way) {
                                // Change
                                context.read<CartBloc>().add(CartUpdateEvent(idCartItem: idCartItem, data: model));
                              } else {
                                // Add
                                context.read<CartBloc>().add(CartAddEvent(data: model));
                              }
                            }, 
                            child: SizedBox(
                              height: 50,
                              width: 100,
                              child: Center(
                                child: Text(
                                  way ? "Add to cart" : "Change",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16
                                  ),
                                ),
                              ),
                            )
                          ); 
                        },
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  int countEvent(DateTime dateTime, List<EventCalender> events) {
    return events.where((element) => element.bookDay == "${dateTime.year}-${dateTime.month}-${dateTime.day}").length;
  }

  List<EventCalender> getEventCalendar(DateTime dateTime, List<EventCalender> events) {
    List<EventCalender> items = [];
    for (EventCalender item in events) {
      if ("${dateTime.year}-${dateTime.month}-${dateTime.day}" == item.bookDay) {
        items.add(item);
      }
    }
    return items;
  }

}