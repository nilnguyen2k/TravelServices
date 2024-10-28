import 'package:bloc/bloc.dart';
import 'package:travelservices/blocs/infor_order_bloc/infor_order_event.dart';
import 'package:travelservices/blocs/infor_order_bloc/infor_order_state.dart';
import 'package:travelservices/repositories/auth_repositories.dart';
import 'package:travelservices/repositories/product_repositories.dart';
import 'package:travelservices/utils/totalValueOrder.dart';

class InforOrderBloc extends Bloc<InforOrderEvent, InforOrderState> {
  AuthRepository authRepo = AuthRepository();
  ProductRepository productRepo = ProductRepository();
  InforOrderBloc() : super(InforOrderState.empty()) {
    on<InforOrderReadCalendarEvent>(onReadCalendar);
    on<InforOrderSelectDayEvent>(onSelectDay);
    on<InforOrderScheduleEvent>(onSchedule);
    on<InforOrderValueTicketEvent>(onValueTicket);
  }

  void onReadCalendar(InforOrderReadCalendarEvent event, Emitter<InforOrderState> emit) async {
    emit(state.copyWith(getLoading: true, haveTicket: false, haveSchedule: false));
    var listCalendar = await authRepo.getListEvent("order/calender");
    
    emit(state.copyWith(
      events: listCalendar, 
      getLoading: false, 
      focusDay: event.focusDay, 
      selectDay: event.selectDay,
      counts: event.count,
      schedule: event.schedule,
      total: event.total
    ));
    
    add(InforOrderSelectDayEvent(
      focusDay: event.focusDay, 
      selectDay: event.selectDay, 
      idService: event.idService
    ));

  }

  void onSelectDay(InforOrderSelectDayEvent event, Emitter<InforOrderState> emit) async {
    emit(state.copyWith(focusDay: event.focusDay, selectDay: event.selectDay, getLoading: true, statusTicket: true));
    var rangeOrder = await productRepo.getRangeOrder("order/range?idService=${event.idService}&day=${event.selectDay.year}-${event.selectDay.month}-${event.selectDay.day}");
    emit(state.copyWith(
      rangeOrderService: rangeOrder, 
      statusTicket: false,
      haveSchedule: rangeOrder.schedules.isEmpty ? false : true,
      haveTicket: rangeOrder.tickets.isEmpty ? false : true
    ));
  }

  void onSchedule(InforOrderScheduleEvent event, Emitter<InforOrderState> emit) {
    emit(state.copyWith(schedule: event.schedule));
  }

  void onValueTicket(InforOrderValueTicketEvent event, Emitter<InforOrderState> emit) {
    
    emit(state.copyWith(statusTicket: true));
    
    if (event.status) {
      List<int> temp = state.counts;
      temp[event.index] = temp[event.index] + 1;
      if (temp[event.index] > state.rangeOrderService.tickets[event.index].amountTicket) {
        temp[event.index] = temp[event.index] -1 ;
      }
      emit(state.copyWith(
        counts: temp, 
        rangeOrderService: state.rangeOrderService, 
        statusTicket: false, 
        total: TotalValueOrder.totalValue(state.rangeOrderService.tickets, temp)
      ));
    } else {
      List<int> temp = state.counts;
      temp[event.index] = temp[event.index] - 1; 
      if (temp[event.index] < 0) {
        temp[event.index] = temp[event.index] + 1;
      } 
      emit(state.copyWith(
        counts: temp, 
        rangeOrderService: state.rangeOrderService, 
        statusTicket: false, 
        total: TotalValueOrder.totalValue(state.rangeOrderService.tickets, temp)
      ));
    }
  }

}