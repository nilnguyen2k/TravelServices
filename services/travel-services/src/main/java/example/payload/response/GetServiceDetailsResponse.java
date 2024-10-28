package example.payload.response;

import java.util.List;

public class GetServiceDetailsResponse {
	
	private InforServiceDetailsResponse service;
	
	private List<TicketResponse> ticket;
	
	private List<LinkDataDetailsResponse> galleries;
	
	private List<ScheduleResponse> schedule;

	public InforServiceDetailsResponse getService() {
		return service;
	}

	public void setService(InforServiceDetailsResponse service) {
		this.service = service;
	}

	public List<TicketResponse> getTicket() {
		return ticket;
	}

	public void setTicket(List<TicketResponse> ticket) {
		this.ticket = ticket;
	}

	public List<LinkDataDetailsResponse> getGalleries() {
		return galleries;
	}

	public void setGalleries(List<LinkDataDetailsResponse> galleries) {
		this.galleries = galleries;
	}

	public List<ScheduleResponse> getSchedule() {
		return schedule;
	}

	public void setSchedule(List<ScheduleResponse> schedule) {
		this.schedule = schedule;
	}
}
