import 'package:equatable/equatable.dart';
import 'package:travelservices/models/infor_order_model.dart';

class InforOrderState extends Equatable {
  
  final bool getLoading;
  final List<EventCalender> events;

  final DateTime selectDay;
  final DateTime focusDay;

  final InforOrder rangeOrderService;

  final String schedule;

  final bool statusTicket;

  final List<int> counts;
  final int total;

  final bool haveTicket;
  final bool haveSchedule;




  const InforOrderState({
    required this.getLoading,
    required this.events,
    required this.selectDay,
    required this.focusDay,
    required this.rangeOrderService,
    required this.schedule,
    required this.statusTicket,
    required this.total,
    required this.counts,
    required this.haveSchedule,
    required this.haveTicket
  });

  factory InforOrderState.empty(){
    return InforOrderState(
      getLoading: false, 
      events: const <EventCalender>[],
      selectDay: DateTime.now(),
      focusDay: DateTime.now(),
      schedule: "",
      statusTicket: false,
      total: 0,
      counts: List.generate(10, (index) => 0),
      rangeOrderService: InforOrder.empty() ,
      haveSchedule: false,
      haveTicket: false
    );
  }

  InforOrderState copyWith({
    bool? getLoading,
    List<EventCalender>? events,
    DateTime? focusDay,
    DateTime? selectDay,
    String? schedule,
    InforOrder? rangeOrderService,
    int? total,
    bool? statusTicket,
    List<int>? counts,
    bool? haveSchedule,
    bool? haveTicket,
  }) {
    return InforOrderState(
      getLoading: getLoading ?? this.getLoading, 
      events: events ?? this.events,
      focusDay: focusDay ?? this.focusDay,
      selectDay: selectDay ?? this.selectDay,
      schedule: schedule ?? this.schedule,
      statusTicket: statusTicket ?? this.statusTicket,
      rangeOrderService: rangeOrderService ?? this.rangeOrderService,
      total: total ?? this.total,
      counts: counts ?? this.counts,
      haveSchedule: haveSchedule ?? this.haveSchedule,
      haveTicket: haveTicket ?? this.haveTicket
    );
  } 

  @override
  List<Object?> get props => [
    getLoading, 
    events, 
    focusDay, 
    selectDay, 
    rangeOrderService, 
    schedule, 
    statusTicket,
    total,
    counts,
    haveSchedule,
    haveTicket
  ];

}