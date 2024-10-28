package example.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import example.elasticsearch.ESMTicket;
import example.entity.ServiceEntity;
import example.entity.TicketEntity;
import example.payload.request.CreateTicketRequest;
import example.payload.request.TicketRequest;
import example.payload.response.TicketResponse;
import example.repository.ServiceRepository;
import example.repository.TicketRepository;
import example.service.ITicketService;

@Service
public class TicketService implements ITicketService {

	@Autowired
	TicketRepository ticketRepository;
	
	@Autowired
	ServiceRepository serviceRepository;
	
	@Override
	public TicketEntity createTicket2(TicketRequest request, Long serviceId) {
		ServiceEntity serviceEntity = serviceRepository.findOneById(serviceId);
		TicketEntity ticketEntity = new TicketEntity();
		ticketEntity.setType(request.getTypeTicket());
		ticketEntity.setValue(request.getValueTicket());
		ticketEntity.setAmount(request.getAmountTicket());
		ticketEntity.setNote(request.getNoteTicket());
		ticketEntity.setServiceTicket(serviceEntity);	
		ticketRepository.save(ticketEntity);
		return ticketEntity;
	}

	@Override
	public List<ESMTicket> convertToESMTicket(Long idService) {
		List<TicketEntity> ticketsEntity = ticketRepository.findAllByServiceTicketId(idService);
		List<ESMTicket> esmTicket = new ArrayList<>();
		for (TicketEntity ticket : ticketsEntity) {
			esmTicket.add(new ESMTicket(ticket.getId(), ticket.getValue(), ticket.getType(), ticket.getAmount()));
		}
		return esmTicket;
	}
	
	@Override
	public TicketResponse convertToTicketResponse(TicketEntity entity) {
		TicketResponse response = new TicketResponse();
		response.setIdTicket(entity.getId());
		response.setAmountTicket(entity.getAmount());
		response.setNote(entity.getNote());
		response.setTypeTicket(entity.getType());
		response.setValueTicket(entity.getValue());
		return response;
	}

	@Override
	public TicketResponse createTicket1(CreateTicketRequest request) {
		ServiceEntity serviceEntity = serviceRepository.findOneById(request.getIdService());
		TicketEntity ticketEntity = new TicketEntity();
		ticketEntity.setType(request.getTypeTicket());
		ticketEntity.setValue(request.getValueTicket());
		ticketEntity.setAmount(request.getAmountTicket());
		ticketEntity.setNote(request.getNoteTicket());
		ticketEntity.setServiceTicket(serviceEntity);	
		ticketRepository.save(ticketEntity);
		return convertToTicketResponse(ticketEntity);
	}

	@Override
	public TicketResponse modifyTicket(TicketResponse request) {
		TicketEntity ticketEntity = ticketRepository.findOneById(request.getIdTicket());
		ticketEntity.setType(request.getTypeTicket());
		ticketEntity.setValue(request.getValueTicket());
		ticketEntity.setAmount(request.getAmountTicket());
		ticketEntity.setNote(request.getNote());
		ticketRepository.save(ticketEntity);
		return convertToTicketResponse(ticketEntity);
	}
}
