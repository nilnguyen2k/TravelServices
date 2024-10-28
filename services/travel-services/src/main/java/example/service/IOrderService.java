package example.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Pageable;

import example.elasticsearch.ESMTicket;
import example.entity.OrderEntity;
import example.entity.OrderItemEntity;
import example.entity.TicketEntity;
import example.payload.request.CartRequest;
import example.payload.request.InforRequest;
import example.payload.request.OrderRequest;
import example.payload.response.CalenderOrderResponse;
import example.payload.response.GetOrderItemResponse;
import example.payload.response.MessageResponse;
import example.payload.response.OrderObjectResponse;
import example.payload.response.OrderResponse;
import example.payload.response.RangeOrderResponse;
import example.payload.response.TicketResponse;

public interface IOrderService {
	Optional<OrderResponse> createOrder(OrderRequest request);
	List<OrderObjectResponse> findAll(Pageable pageable);
	OrderObjectResponse findOne(Long idOrder);
	int totalOrderPrice(List<CartRequest> items);
	int totalOrderItemPrice(List<TicketResponse> tickets);
	InforRequest convertToInforRequest(Long idOrder);
	List<CartRequest> convertToListCartRequest(List<OrderItemEntity> listOrderItem);
	OrderObjectResponse convertToOrderObjectResponse(OrderEntity order);
	int totalItem();
	
	ESMTicket convertToESMTicket(TicketEntity ticket);
	
	
	List<CalenderOrderResponse> listCalenderOrderByUser();
	RangeOrderResponse rangeOrder(String day, Long idService);
	
	List<GetOrderItemResponse> getAllOrderItemByStatus(String status);
	
	List<GetOrderItemResponse> getAllAdminOrderItemByStatus(String status);
	
	void updateStatusOrderItem(String status, Long idOrderItem);
	
	MessageResponse updateStatusOrderItemForUser(String status, long idOrderItem);
	
}
