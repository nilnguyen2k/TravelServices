package example.payload.response;

import java.util.List;

public class RangeOrderResponse {
	
	private Long id;
	
	private List<TicketResponse> tickets;
	
	private List<ScheduleResponse> schedules;
	
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public List<TicketResponse> getTickets() {
		return tickets;
	}
	
	public void setTickets(List<TicketResponse> tickets) {
		this.tickets = tickets;
	}
	
	public List<ScheduleResponse> getSchedules() {
		return schedules;
	}
	
	public void setSchedules(List<ScheduleResponse> schedules) {
		this.schedules = schedules;
	}
	
}
