package example.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import example.payload.request.CreateScheduleRequest;
import example.payload.request.CreateTicketRequest;
import example.payload.response.ScheduleResponse;
import example.payload.response.TicketResponse;
import example.service.impl.ScheduleService;
import example.service.impl.TicketService;

@CrossOrigin
@RestController
public class TicketAPI {
	
	@Autowired
	TicketService ticketService;
	
	@Autowired
	ScheduleService scheduleService;
	
	@PostMapping(value = "/admin/ticket")
	public TicketResponse createTicket(@RequestBody CreateTicketRequest request) {
		TicketResponse ticketResponse = new TicketResponse();
		ticketResponse = ticketService.createTicket1(request);
		return ticketResponse; 
	}
	
	@PostMapping(value = "/admin/schedule") 
	public ScheduleResponse createSchedule(@RequestBody CreateScheduleRequest request){
		ScheduleResponse scheduleResponse = new ScheduleResponse();
		scheduleResponse = scheduleService.createSchedule1(request);
		return scheduleResponse;
	}
}
