package example.payload.request;

import java.util.List;

import example.payload.response.LinkDataResponse;
import example.payload.response.ScheduleResponse;
import example.payload.response.TicketResponse;

public class ModifyServiceRequest {
	
	private ServiceRequest service;
	
	private List<TicketResponse> ticket;
	
	private List<LinkDataResponse> galleries;
	
	private List<ScheduleResponse> schedule;

	public ServiceRequest getService() {
		return service;
	}

	public void setService(ServiceRequest service) {
		this.service = service;
	}

	public List<TicketResponse> getTicket() {
		return ticket;
	}

	public void setTicket(List<TicketResponse> ticket) {
		this.ticket = ticket;
	}

	public List<LinkDataResponse> getGalleries() {
		return galleries;
	}

	public void setGalleries(List<LinkDataResponse> galleries) {
		this.galleries = galleries;
	}

	public List<ScheduleResponse> getSchedule() {
		return schedule;
	}

	public void setSchedule(List<ScheduleResponse> schedule) {
		this.schedule = schedule;
	}
	
}
