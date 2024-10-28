package example.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import example.config.jwt.CustomUserDetails;
import example.elasticsearch.ESMService;
import example.elasticsearch.ESMTicket;
import example.entity.OrderEntity;
import example.entity.OrderItemByTicketEntity;
import example.entity.OrderItemEntity;
import example.entity.ScheduleEntity;
import example.entity.ServiceEntity;
import example.entity.TicketEntity;
import example.entity.UserEntity;
import example.payload.request.CartRequest;
import example.payload.request.InforRequest;
import example.payload.request.OrderRequest;
import example.payload.response.CalenderOrderResponse;
import example.payload.response.GetOrderItemResponse;
import example.payload.response.MessageResponse;
import example.payload.response.OrderItemResponse;
import example.payload.response.OrderObjectResponse;
import example.payload.response.OrderResponse;
import example.payload.response.RangeOrderResponse;
import example.payload.response.ScheduleResponse;
import example.payload.response.TicketResponse;
import example.repository.CartItemByTicketRepository;
import example.repository.CartItemRepository;
import example.repository.CartRepository;
import example.repository.ESServiceRepository;
import example.repository.OrderItemByTicketRepository;
import example.repository.OrderItemRepository;
import example.repository.OrderRepository;
import example.repository.ScheduleRepository;
import example.repository.ServiceRepository;
import example.repository.TicketRepository;
import example.repository.UserRepository;
import example.service.IOrderService;

@Service
public class OrderService implements IOrderService {
	
	@Autowired
	OrderRepository orderRepository;
	
	@Autowired
	OrderItemRepository orderItemRepository;
	
	@Autowired
	OrderItemByTicketRepository orderItemByTicketRepository;
	
	@Autowired
	CartRepository cartRepository;
	
	@Autowired
	CartItemRepository cartItemRepository;
	
	@Autowired
	CartItemByTicketRepository cartItemByTicketRepository;
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	ServiceRepository serviceRepository;
	
	@Autowired
	TicketRepository ticketRepository;
	
	@Autowired
	ScheduleRepository scheduleRepository;
	
	@Autowired
	ESServiceRepository esServiceRepository;
	
	@Autowired
	JavaMailSender mailSender;

	@Override
	public Optional<OrderResponse> createOrder(OrderRequest request) {
		
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		OrderEntity orderEntity = new OrderEntity();
		orderEntity.setCreateDate(new Date());
		orderEntity.setModifiedDate(new Date());
		orderEntity.setEmail(request.getInfor().getEmail());
		orderEntity.setFullname(request.getInfor().getFullname());
		orderEntity.setPhone(request.getInfor().getPhone());
		orderEntity.setUserOrder(userEntity);
		orderEntity.setTotal(totalOrderPrice(request.getItems()));
		orderEntity.setOrderStatus(true);
		
		OrderEntity rsOrder = orderRepository.save(orderEntity);
		
		if (rsOrder != null) {
			
			List<OrderItemEntity> listOrderItem = new ArrayList<>();
			
			for (int i = 0; i < request.getItems().size(); i++) {
				
				// Khai bao
				ESMService esmService = esServiceRepository.findOneById(request.getItems().get(i).getIdService());
				List<ESMTicket> esmTickets = new ArrayList<>();
				
				OrderItemEntity orderItem = new OrderItemEntity();
				orderItem.setCreateDate(new Date());
				orderItem.setModifiedDate(new Date());
				orderItem.setBookDay(request.getItems().get(i).getBookDay());
				orderItem.setBookTime(request.getItems().get(i).getBookTime());
				orderItem.setNote(request.getItems().get(i).getNote());
				orderItem.setOrderOrderItem(rsOrder);
				orderItem.setTotal(totalOrderItemPrice(request.getItems().get(i).getTickets()));
				orderItem.setServiceOrderItem(serviceRepository.findOneById(request.getItems().get(i).getIdService()));
				orderItem.setStatus("waiting");
				OrderItemEntity rsOrderItem = orderItemRepository.save(orderItem);
				listOrderItem.add(rsOrderItem);
				
				if (rsOrderItem != null) {
					for (TicketResponse ticket : request.getItems().get(i).getTickets()) {
						
						OrderItemByTicketEntity orderItemByTicketEntity = new OrderItemByTicketEntity();
						orderItemByTicketEntity.setAmount(ticket.getAmountTicket());
						orderItemByTicketEntity.setCurrentPrice(ticket.getValueTicket());
						orderItemByTicketEntity.setType(ticket.getTypeTicket());
						orderItemByTicketEntity.setOrderItemBy(rsOrderItem);
						
						// Handle ticket by
						TicketEntity ticketEntity = ticketRepository.findOneById(ticket.getIdTicket());
						orderItemByTicketEntity.setTicketBy(ticketEntity);
						ticketEntity.setAmount(ticketEntity.getAmount() - ticket.getAmountTicket());	
						ticketRepository.save(ticketEntity);
						orderItemByTicketRepository.save(orderItemByTicketEntity);
						
						// Handle elasticsearch
						esmTickets.add(convertToESMTicket(ticketEntity));
					}
				}
				
				if (!request.isStatusOrder()) {
					// Mua thong qua gio hang
					 cartItemByTicketRepository.deleteAll(cartItemByTicketRepository.findAllByCartItemById(request.getItems().get(i).getIdCartItem()));
					 cartItemRepository.deleteById(request.getItems().get(i).getIdCartItem());
				}
				
				// Update order elasticsearch
				esmService.setOrders(esmService.getOrders() + 1);
				esmService.setTicket(esmTickets);
				esServiceRepository.save(esmService);
				
			}
			
			
			
			return Optional.ofNullable(new OrderResponse(rsOrder.getId(), convertToInforRequest(rsOrder.getId()), convertToListCartRequest(listOrderItem)));
		} throw new NullPointerException();
	}
	
	
	@Override
	public int totalOrderPrice(List<CartRequest> items) {
		int total = 0;
		for (CartRequest item : items) {
			total = total + totalOrderItemPrice(item.getTickets());
		}
		return total;
	}
	
	@Override
	public int totalOrderItemPrice(List<TicketResponse> tickets) {
		int total = 0;
		for (TicketResponse ticket : tickets) {
			total = total + ticket.getAmountTicket()*ticket.getValueTicket();
		}
		return total;
	}

	@Override
	public InforRequest convertToInforRequest(Long idOrder) {
		OrderEntity orderEntity = orderRepository.findOneById(idOrder);
		InforRequest infor = new InforRequest();
		infor.setEmail(orderEntity.getEmail());
		infor.setPhone(orderEntity.getPhone());
		infor.setFullname(orderEntity.getFullname());
		return infor;
	}
	
	@Override
	public List<CartRequest> convertToListCartRequest(List<OrderItemEntity> listOrderItem) {
		List<CartRequest> listCartRequest = new ArrayList<>();
		for (int i = 0; i < listOrderItem.size(); i++) {
			CartRequest cartRequest = new CartRequest();
			cartRequest.setBookDay(listOrderItem.get(i).getBookDay());
			cartRequest.setBookTime(listOrderItem.get(i).getBookTime());
			cartRequest.setIdService(listOrderItem.get(i).getServiceOrderItem().getId());
			cartRequest.setNote(listOrderItem.get(i).getNote());
			List<OrderItemByTicketEntity> orderItemByTickets = orderItemByTicketRepository.findAllByOrderItemById(listOrderItem.get(i).getId());
			List<TicketResponse> listTicket = new ArrayList<>();
			for (OrderItemByTicketEntity orderItemTicket : orderItemByTickets) {
				TicketResponse ticket = new TicketResponse();
				ticket.setIdTicket(orderItemTicket.getTicketBy().getId());
				ticket.setAmountTicket(orderItemTicket.getAmount());
				ticket.setNote(ticketRepository.findOneById(orderItemTicket.getTicketBy().getId()).getNote());
				ticket.setTypeTicket(orderItemTicket.getType());
				ticket.setValueTicket(orderItemTicket.getCurrentPrice());
				listTicket.add(ticket);
			}
			ESMService service = esServiceRepository.findOneById(listOrderItem.get(i).getServiceOrderItem().getId());
			cartRequest.setName(service.getName());
			cartRequest.setDescription(service.getDescription());
			cartRequest.setUrl(service.getImage());
			
			cartRequest.setTickets(listTicket);
			listCartRequest.add(cartRequest);
		}
		
		return listCartRequest;
	}



	@Override
	public List<OrderObjectResponse> findAll(org.springframework.data.domain.Pageable pageable) {
		
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		List<OrderObjectResponse> listOrder = new ArrayList<>();
		
		List<OrderEntity> orders = orderRepository.findByUserOrderId(userEntity.getId(), pageable).getContent();
		if (orders != null) {
			for (OrderEntity order : orders) {
				listOrder.add(convertToOrderObjectResponse(order));
			}
		}
		return listOrder;
	}
	
	@Override
	public int totalItem() {
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		return (int) orderRepository.findAllByUserOrderId(userEntity.getId()).size();
	}



	@Override
	public OrderObjectResponse findOne(Long idOrder) {
		OrderEntity orderEntity = orderRepository.findOneById(idOrder);
		return convertToOrderObjectResponse(orderEntity);
	}
	
	@Override
	public OrderObjectResponse convertToOrderObjectResponse(OrderEntity order) {
		OrderObjectResponse response = new OrderObjectResponse();
		
		InforRequest infor = new InforRequest();
		response.setIdOrder(order.getId());
		infor.setEmail(order.getEmail());
		infor.setFullname(order.getFullname());
		infor.setPhone(order.getPhone());
		response.setInfor(infor);
		response.setCreateDate(order.getCreateDate());
		response.setTotalOrder(order.getTotal());
		
		List<OrderItemResponse> lstItem = new ArrayList<>();
		
		for (OrderItemEntity orderItem : orderItemRepository.findAllByOrderOrderItemId(order.getId())) {
			OrderItemResponse item = new OrderItemResponse();
			item.setBookDay(orderItem.getBookDay());
			item.setBookTime(orderItem.getBookTime());
			item.setCreateDate(orderItem.getCreateDate());
			item.setIdService(orderItem.getServiceOrderItem().getId());
			item.setTotalItem(orderItem.getTotal());
			List<TicketResponse> tickets = new ArrayList<>(); 
			for (OrderItemByTicketEntity itembyticket : orderItemByTicketRepository.findAllByOrderItemById(orderItem.getId())) {
				TicketResponse ticket = new TicketResponse();
				ticket.setAmountTicket(itembyticket.getAmount());
				ticket.setIdTicket(itembyticket.getTicketBy().getId());
				ticket.setNote(ticketRepository.findOneById(itembyticket.getTicketBy().getId()).getNote());
				ticket.setTypeTicket(itembyticket.getType());
				ticket.setValueTicket(itembyticket.getCurrentPrice());
				tickets.add(ticket);
			}
			ESMService service = esServiceRepository.findOneById(orderItem.getServiceOrderItem().getId());
			item.setName(service.getName());
			item.setDescription(service.getDescription());
			item.setUrl(service.getImage());
			item.setTickets(tickets);
			lstItem.add(item);	
		}
		response.setItems(lstItem);
		
		return response;
	}


	@Override
	public List<CalenderOrderResponse> listCalenderOrderByUser() {
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		List<CalenderOrderResponse> response = new ArrayList<>();
		
		List<OrderEntity> listOrder = orderRepository.findAllByUserOrderId(userEntity.getId());
		for (OrderEntity order : listOrder) {
			List<OrderItemEntity> items = orderItemRepository.findAllByOrderOrderItem(order);
			for (OrderItemEntity item : items) {
				CalenderOrderResponse rs = new CalenderOrderResponse();
				rs.setBookDay(item.getBookDay());
				rs.setBookTime(item.getBookTime());
				rs.setService(serviceRepository.findOneById(item.getServiceOrderItem().getId()).getName());
				rs.setStatus(item.getStatus());
				response.add(rs);
			}
		}
		return response;
	}


	@Override
	public RangeOrderResponse rangeOrder(String day, Long idService) {
		
		RangeOrderResponse response = new RangeOrderResponse();
		
		List<TicketResponse> tickets = new ArrayList<>();
		List<ScheduleResponse> schedules = new ArrayList<>();
		
		List<ScheduleEntity> listSchedule = scheduleRepository.findAllByServiceScheduleId(idService);
		List<TicketEntity> listTicket = ticketRepository.findAllByServiceTicketId(idService);
		
		for (TicketEntity ticket : listTicket) {
			TicketResponse ticketResponse = new TicketResponse();
			ticketResponse.setIdTicket(ticket.getId());
			ticketResponse.setAmountTicket(ticket.getAmount());
			ticketResponse.setNote(ticket.getNote());
			ticketResponse.setTypeTicket(ticket.getType());
			ticketResponse.setValueTicket(ticket.getValue());
			tickets.add(ticketResponse);
		}
		
		for (ScheduleEntity schedule : listSchedule) {
			ScheduleResponse scheduleResponse = new ScheduleResponse();
			
			List<OrderItemEntity> items = orderItemRepository.findAllByBookDayAndServiceOrderItemAndBookTime(day, serviceRepository.findOneById(idService), schedule.getTime());
			
			scheduleResponse.setId(schedule.getId());
			scheduleResponse.setTime(schedule.getTime());
			scheduleResponse.setQuantityPerDay(schedule.getQuantityperday() - items.size());
			
			schedules.add(scheduleResponse);
		}
		
		// Set value
		response.setId(idService);
		response.setTickets(tickets);
		response.setSchedules(schedules);
		
		return response;
	}


	@Override
	public ESMTicket convertToESMTicket(TicketEntity ticket) {
		return new ESMTicket(ticket.getId(), ticket.getValue(), ticket.getType(), ticket.getAmount());
	}


	@Override
	public List<GetOrderItemResponse> getAllOrderItemByStatus(String status) {
		
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		List<OrderEntity> listOrder = orderRepository.findAllByUserOrderId(userEntity.getId());
		List<GetOrderItemResponse> listResponse = new ArrayList<>();
		
		for (OrderEntity entity : listOrder) {
			
			List<OrderItemEntity> orderItemEntity = orderItemRepository.findAllByOrderOrderItemAndStatus(entity, status);
			
			for (OrderItemEntity item : orderItemEntity) {
				
				ServiceEntity service = serviceRepository.findOneById(item.getServiceOrderItem().getId());
				
				InforRequest infor = new InforRequest();
				infor.setEmail(entity.getEmail());
				infor.setFullname(entity.getFullname());
				infor.setPhone(entity.getPhone());
				
				List<OrderItemByTicketEntity> tickets = orderItemByTicketRepository.findAllByOrderItemById(entity.getId());
				List<TicketResponse> listTicketResponse = new ArrayList<>();
				for (OrderItemByTicketEntity ticket : tickets) {
					TicketResponse ticketResponse = new TicketResponse();
					ticketResponse.setIdTicket(ticket.getId());
					ticketResponse.setAmountTicket(ticket.getAmount());
					ticketResponse.setTypeTicket(ticket.getType());
					ticketResponse.setValueTicket(ticket.getCurrentPrice());
					ticketResponse.setNote(ticket.getTicketBy().getNote());
					listTicketResponse.add(ticketResponse);
				}
				
				
				GetOrderItemResponse response = new GetOrderItemResponse();
				
				response.setId(item.getId());
				response.setIdOrder(entity.getId());
				response.setIdService(service.getId());
				response.setNameService(service.getName());
				response.setDescription(service.getDescription());
				response.setUrl(esServiceRepository.findOneById(item.getServiceOrderItem().getId()).getImage());
				response.setBookDay(item.getBookDay());
				response.setBookTime(item.getBookTime());
				response.setTotal(item.getTotal());
				response.setInfor(infor);
				response.setTickets(listTicketResponse);
				response.setCreateDate(item.getCreateDate());
				response.setModifiedDate(item.getModifiedDate());
				
				listResponse.add(response);
			}
			
		}
		return listResponse;
	}


	@Override
	public List<GetOrderItemResponse> getAllAdminOrderItemByStatus(String status) {
		/// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		List<GetOrderItemResponse> listResponse = new ArrayList<>();
		
		List<ServiceEntity> listService = serviceRepository.findAllByUserService(userEntity);
				
		for (ServiceEntity service : listService) {
			List<OrderItemEntity> listOrderItem = orderItemRepository.findAllByServiceOrderItemAndStatus(service, status);
			for (OrderItemEntity item : listOrderItem) {
				
				// OrderEntity entity = orderRepository.findOneById(null);
				
				InforRequest infor = new InforRequest();
				infor.setEmail(item.getOrderOrderItem().getEmail());
				infor.setFullname(item.getOrderOrderItem().getFullname());
				infor.setPhone(item.getOrderOrderItem().getPhone());
				
				List<OrderItemByTicketEntity> tickets = orderItemByTicketRepository.findAllByOrderItemById(item.getId());
				List<TicketResponse> listTicketResponse = new ArrayList<>();
				for (OrderItemByTicketEntity ticket : tickets) {
					TicketResponse ticketResponse = new TicketResponse();
					ticketResponse.setIdTicket(ticket.getId());
					ticketResponse.setAmountTicket(ticket.getAmount());
					ticketResponse.setTypeTicket(ticket.getType());
					ticketResponse.setValueTicket(ticket.getCurrentPrice());
					ticketResponse.setNote(ticket.getTicketBy().getNote());
					listTicketResponse.add(ticketResponse);
				}
				
				
				GetOrderItemResponse response = new GetOrderItemResponse();
				
				response.setId(item.getId());
				response.setIdOrder(item.getOrderOrderItem().getId());
				response.setIdService(service.getId());
				response.setNameService(service.getName());
				response.setDescription(service.getDescription());
				response.setUrl(esServiceRepository.findOneById(item.getServiceOrderItem().getId()).getImage());
				response.setBookDay(item.getBookDay());
				response.setBookTime(item.getBookTime());
				response.setTotal(item.getTotal());
				response.setInfor(infor);
				response.setTickets(listTicketResponse);
				response.setCreateDate(item.getCreateDate());
				response.setModifiedDate(item.getModifiedDate());
				
				listResponse.add(response);
			}
		}
		
		return listResponse;
	}


	@Override
	public void updateStatusOrderItem(String status, Long idOrderItem) {
		OrderItemEntity item = orderItemRepository.findOneById(idOrderItem);
		item.setStatus(status);
		OrderItemEntity itemResponse = orderItemRepository.save(item);
		
		
		
		String textStatus = "";
		String content = "";
		
		if (status.equals("approved")) {
			textStatus = "Your order " + idOrderItem + " has been approved.";
		}
		if (status.equals("deleted")) {
			textStatus = "Your order " + idOrderItem + " has been deleted.";
		}
		
		content = content + textStatus + "<br>";
		content = content + "<b>About</b><br>";
		content = content + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name: " + itemResponse.getServiceOrderItem().getName() + "<br>";
		content = content + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Time: " + itemResponse.getBookDay() + " " + itemResponse.getBookTime() + "<br>";
		content = content + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tickets: <br>";
		
		for (int i = 0; i < itemResponse.getListOrderByTicket().size(); i++) {
			int index = i + 1;
			content = content + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Ticket " + index + "<br>";
			content = content + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "+ Type: " + itemResponse.getListOrderByTicket().get(i).getType() + "<br>";
			content = content + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "+ Value: " + itemResponse.getListOrderByTicket().get(i).getCurrentPrice() + "<br>";
			content = content + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "+ Amount: " + itemResponse.getListOrderByTicket().get(i).getAmount() + "<br>";
		}
		content = content + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total: " + itemResponse.getTotal() + "<br>";
		content = content + "<img src=\"" + esServiceRepository.findOneById(itemResponse.getServiceOrderItem().getId()).getImage() + "\" width=\"300\" height=\"300\">";
		// Send Email
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);
		
		try {
			helper.setFrom("quocnil2000@gmail.com");
			helper.setTo(itemResponse.getOrderOrderItem().getEmail());
			helper.setText(content, true);
			helper.setSubject("From FTService");
			mailSender.send(message);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


	@Override
	public MessageResponse updateStatusOrderItemForUser(String status, long idOrderItem) {		
		OrderItemEntity item = orderItemRepository.findOneById(idOrderItem);
		item.setStatus(status);
		orderItemRepository.save(item);
		return new MessageResponse("Success");
	}


	
	
	
}
