package example.api;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import example.payload.request.OrderRequest;
import example.payload.response.AdminOrderItemResponse;
import example.payload.response.CalenderOrderResponse;
import example.payload.response.GetOrderItemResponse;
import example.payload.response.MessageResponse;
import example.payload.response.OrderResponse;
import example.payload.response.RangeOrderResponse;
import example.service.impl.OrderService;

@CrossOrigin
@RestController
public class OrderAPI {
	
	@Autowired
	OrderService orderService;
	
	@PostMapping(value = "/order")
	public Optional<OrderResponse> createOrder(@RequestBody OrderRequest request) {
		return orderService.createOrder(request);
	}
	
//	@GetMapping(value = "/orders")
//	public GetOrderResponse getOrders(@RequestParam("page") int page, @RequestParam("limit") int limit, @RequestParam("sort") String sort) {
//		GetOrderResponse result = new GetOrderResponse();
//		result.setPage(page);
//		Sort sortable = null;
//		if (sort.equals("ASC")) {
//			sortable = Sort.by("id").ascending();
//		}
//		if (sort.equals("DESC")) {
//			sortable = Sort.by("id").descending();
//		}
//		Pageable pageable =  PageRequest.of(page-1,limit, sortable);
//		result.setData(orderService.findAll(pageable));
//		result.setTotalPage((int)Math.ceil((double)orderService.totalItem() / limit));
//		return result;
//	}
//	
//	@GetMapping(value = "/order/{idOrder}")
//	public OrderObjectResponse getOrderDetails(@PathVariable("idOrder") int idOrder) {
//		return orderService.findOne((long) idOrder);
//	}
	
	@GetMapping(value = "/orderitem/{status}")
	public List<GetOrderItemResponse> getOrderItemByStatus(@PathVariable("status") String status) {
		return orderService.getAllOrderItemByStatus(status);
	}
	
	@GetMapping(value = "/order/calender")
	public List<CalenderOrderResponse> calenderEvent() {
		return orderService.listCalenderOrderByUser();
	}
	
	@GetMapping(value = "/order/range")
	public RangeOrderResponse rangeOrder(@RequestParam("day") String day, @RequestParam("idService") Long idService) {
		return orderService.rangeOrder(day, idService);
	}
	
	@GetMapping(value = "/admin/orderitem/{status}")
	public AdminOrderItemResponse getAdminOrderItemByStatus(@PathVariable("status") String status, @RequestParam("page") int page, @RequestParam("limit") int limit) {
		
		AdminOrderItemResponse response = new AdminOrderItemResponse();
		
		List<GetOrderItemResponse> list = orderService.getAllAdminOrderItemByStatus(status); 
		list.sort(Comparator.comparing(GetOrderItemResponse::getId)
	                .thenComparing(GetOrderItemResponse::getId));
		Collections.reverse(list);
		
		
		response.setPage(page);
		response.setTotalPage((int)Math.ceil((double)list.size() / limit));
		
		if (page != 1) {
			List<GetOrderItemResponse> listSlit = list.stream().skip(limit*page - 1).limit(limit).collect(Collectors.toList());
			response.setData(listSlit);
		} else {
			List<GetOrderItemResponse> listSlit = list.stream().limit(limit).collect(Collectors.toList());
			response.setData(listSlit);
		}
		

		
		
		return response;
	}
	
	@PutMapping(value = "/admin/orderitem/update/{idOrderItem}")
	public AdminOrderItemResponse updateAdminOrderItemByStatus(
			@PathVariable("idOrderItem") String idOrderItem, 
			@RequestParam("page") int page, 
			@RequestParam("limit") int limit,
			@RequestParam("status") String status,
			@RequestParam("statusShow") String statusShow
		) {
		
		orderService.updateStatusOrderItem(status, Long.parseLong(idOrderItem));
		
		AdminOrderItemResponse response = new AdminOrderItemResponse();
		
		List<GetOrderItemResponse> list = orderService.getAllAdminOrderItemByStatus(statusShow); 
		list.sort(Comparator.comparing(GetOrderItemResponse::getId)
	                .thenComparing(GetOrderItemResponse::getId));
		Collections.reverse(list);
		
		response.setPage(page);
		response.setTotalPage((int)Math.ceil((double)list.size() / limit));
		
		if (page != 1) {
			List<GetOrderItemResponse> listSlit = list.stream().skip(limit*page - 1).limit(limit).collect(Collectors.toList());
			response.setData(listSlit);
		} else {
			List<GetOrderItemResponse> listSlit = list.stream().limit(limit).collect(Collectors.toList());
			response.setData(listSlit);
		}
		return response;
	}
	
	@PutMapping(value = "/user/orderitem/update")
	public MessageResponse updateOrderItemStatus(@RequestParam("idOrderItem") String idOrderItem, @RequestParam("status") String status) {
		return orderService.updateStatusOrderItemForUser(status, Long.parseLong(idOrderItem));
	}
	
	
}
