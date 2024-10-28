package example.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Pageable;

import example.entity.CartEntity;
import example.payload.request.CartRequest;
import example.payload.response.CartResponse;
import example.payload.response.GetCartResponse;
import example.payload.response.TicketResponse;

public interface ICartService {
	Optional<CartResponse> createCart(CartRequest request);
	boolean deleteCart(Long cartItemId);
	Optional<CartResponse> updateCart(CartRequest request, Long cartItemId);
	List<CartResponse> findAll(Pageable pageable);
	Optional<CartResponse> saveCartItemAndTicket(CartEntity cartEntity, CartRequest request);
	List<TicketResponse> convertListTicketResponse(CartRequest cartRequest);
	int totalItem();
}
