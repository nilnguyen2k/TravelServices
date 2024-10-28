package example.service;

import java.util.List;

import example.elasticsearch.ESMTicket;
import example.entity.TicketEntity;
import example.payload.request.CreateTicketRequest;
import example.payload.request.TicketRequest;
import example.payload.response.TicketResponse;

public interface ITicketService {
	TicketEntity createTicket2(TicketRequest request, Long serviceId);
	TicketResponse createTicket1(CreateTicketRequest request);
	TicketResponse modifyTicket(TicketResponse request);
	List<ESMTicket> convertToESMTicket(Long idService);
	TicketResponse convertToTicketResponse(TicketEntity entity);
}
