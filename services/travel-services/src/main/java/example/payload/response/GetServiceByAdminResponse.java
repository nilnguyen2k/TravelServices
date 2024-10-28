package example.payload.response;

import java.util.List;

public class GetServiceByAdminResponse {
	
	private ServiceResponse service;
	
	private List<TicketResponse> ticket;
	
	private List<LinkDataResponse> galleries;
	
	private List<ScheduleResponse> schedule;

	public ServiceResponse getService() {
		return service;
	}

	public void setService(ServiceResponse service) {
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
