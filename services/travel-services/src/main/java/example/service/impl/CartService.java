package example.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import example.config.jwt.CustomUserDetails;
import example.elasticsearch.ESMService;
import example.entity.CartEntity;
import example.entity.CartItemByTicketEntity;
import example.entity.CartItemEntity;
import example.entity.ServiceEntity;
import example.entity.TicketEntity;
import example.entity.UserEntity;
import example.payload.request.CartRequest;
import example.payload.response.CartResponse;
import example.payload.response.TicketResponse;
import example.repository.CartItemByTicketRepository;
import example.repository.CartItemRepository;
import example.repository.CartRepository;
import example.repository.ESServiceRepository;
import example.repository.ServiceRepository;
import example.repository.TicketRepository;
import example.repository.UserRepository;
import example.service.ICartService;

@Service
public class CartService implements ICartService {
	
	@Autowired
	CartRepository cartRepository;
	
	@Autowired
	CartItemRepository cartItemRepository;
	
	@Autowired
	CartItemByTicketRepository cartItemByticketRepository;
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	ServiceRepository serviceRepository;
	
	@Autowired
	TicketRepository ticketRepository;
	
	@Autowired
	ESServiceRepository esServiceRepository;
	
	@Override
	public Optional<CartResponse> createCart(CartRequest request) {
		
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		// Check
		CartEntity cartEntity1 = cartRepository.findOneByUserCartId(userEntity.getId());
		
		if (cartEntity1 != null) {
			return saveCartItemAndTicket(cartEntity1, request);
		} else {
			CartEntity cart = new CartEntity();
			cart.setUserCart(userEntity);
			cart.setCreateDate(new Date());
			cart.setModifiedDate(new Date());
			CartEntity cartEntity2 = cartRepository.save(cart);
			return saveCartItemAndTicket(cartEntity2, request);
		}
	}
	
	@Override
	public Optional<CartResponse> saveCartItemAndTicket(CartEntity cartEntity, CartRequest request) {
		CartItemEntity cartItem = new CartItemEntity(); 
		cartItem.setBookDay(request.getBookDay());
		cartItem.setBookTime(request.getBookTime());
		cartItem.setCreateDate(new Date());
		cartItem.setModifiedDate(new Date());
		cartItem.setCartCartItem(cartEntity);
		cartItem.setServiceCartItem(serviceRepository.findOneById(request.getIdService()));
		CartItemEntity rsCartItem = cartItemRepository.save(cartItem);  
		if (rsCartItem != null) {
			for (TicketResponse ticket : request.getTickets()) {
				CartItemByTicketEntity cartItemByTicket = new CartItemByTicketEntity();
				cartItemByTicket.setAmount(ticket.getAmountTicket());
				cartItemByTicket.setCartItemBy(rsCartItem);
				cartItemByTicket.setCartTicketBy(ticketRepository.findOneById(ticket.getIdTicket()));
				cartItemByticketRepository.save(cartItemByTicket);
			}
			return Optional.ofNullable(
					new CartResponse (
							rsCartItem.getId(), 
							request.getIdService(),
							request.getName(),
							request.getDescription(),
							request.getUrl(),
							request.getBookDay(), 
							request.getBookTime(), 
							convertListTicketResponse(request)
					));
		}
		throw new NullPointerException();
	}
	
	@Override
	public List<TicketResponse> convertListTicketResponse(CartRequest cartRequest) {
		List<TicketResponse> listTicket = new ArrayList<>();
		for (int i = 0; i < cartRequest.getTickets().size(); i++) {
			TicketEntity ticket = ticketRepository.findOneById(cartRequest.getTickets().get(i).getIdTicket());
			TicketResponse ticketResponse = new TicketResponse();
			ticketResponse.setTypeTicket(ticket.getType());
			ticketResponse.setAmountTicket(cartRequest.getTickets().get(i).getAmountTicket());
			ticketResponse.setIdTicket(cartRequest.getTickets().get(i).getIdTicket());
			ticketResponse.setNote(ticket.getNote());
			ticketResponse.setValueTicket(ticket.getValue());
			listTicket.add(ticketResponse);
		}
		return listTicket;
	}

	
	@Override
	public boolean deleteCart(Long cartItemId) {
		cartItemByticketRepository.deleteAll(cartItemByticketRepository.findAllByCartItemById(cartItemId));
		cartItemRepository.deleteById(cartItemId);
		boolean isFoundCartItem = cartItemRepository.existsById(cartItemId);
		if (isFoundCartItem) {
			return false;
		} else {
			return true;
		}
	}

	@Override
	public Optional<CartResponse> updateCart(CartRequest request, Long cartItemId) {
		CartItemEntity cartItemEntity = cartItemRepository.findOneById(cartItemId);
		cartItemEntity.setBookDay(request.getBookDay());
		cartItemEntity.setBookTime(request.getBookTime());
		cartItemEntity.setModifiedDate(new Date());
		CartItemEntity cartItem = cartItemRepository.save(cartItemEntity);
		
		if (cartItem != null) {
			List<CartItemByTicketEntity> cartItemByTicket1 = new ArrayList<>();
			List<CartItemByTicketEntity> cartItemByTicket2 = cartItemByticketRepository.findAllByCartItemById(cartItemId);
			for (int i = 0; i < request.getTickets().size(); i++) {
				CartItemByTicketEntity cartItemByTicket = cartItemByticketRepository.findOneByCartItemByIdAndCartTicketById(cartItemId, request.getTickets().get(i).getIdTicket());
				if (cartItemByTicket != null) {
					cartItemByTicket.setAmount(request.getTickets().get(i).getAmountTicket());
					cartItemByticketRepository.save(cartItemByTicket);
					cartItemByTicket1.add(cartItemByTicket);
				} else {
					CartItemByTicketEntity cartItemByTicketEntity = new CartItemByTicketEntity();
					cartItemByTicketEntity.setAmount(request.getTickets().get(i).getAmountTicket());
					cartItemByTicketEntity.setCartItemBy(cartItem);
					cartItemByTicketEntity.setCartTicketBy(ticketRepository.findOneById(request.getTickets().get(i).getIdTicket()));
					cartItemByticketRepository.save(cartItemByTicketEntity);
					cartItemByTicket1.add(cartItemByTicket);
				}
			}
			List<CartItemByTicketEntity> cartItemByTicket3 = new ArrayList<>(cartItemByTicket2);
			cartItemByTicket3.removeAll(cartItemByTicket1);
			cartItemByticketRepository.deleteAll(cartItemByTicket3);
			return Optional.ofNullable(
					new CartResponse (
							cartItemId, 
							request.getIdService(), 
							request.getName(),
							request.getDescription(),
							request.getUrl(),
							request.getBookDay(), 
							request.getBookTime(), 
							convertListTicketResponse(request)
					));
		}
		throw new NullPointerException();
	}

	@Override
	public List<CartResponse> findAll(Pageable pageable) {
		
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		List<CartResponse> response = new ArrayList<>();
		
		CartEntity cartEntity = cartRepository.findOneByUserCartId(userEntity.getId());
		
		if (cartEntity == null) {
			CartEntity cart = new CartEntity();
			cart.setUserCart(userEntity);
			cart.setCreateDate(new Date());
			cart.setModifiedDate(new Date());
			cartRepository.save(cart);
			return response;
		} else {
			
			List<CartItemEntity> cartItems = cartItemRepository.findAllByCartCartItemId(cartEntity.getId(), pageable).getContent();
			
			for (CartItemEntity cartItem : cartItems) {
				List<TicketResponse> tickets = new ArrayList<>();
				for (CartItemByTicketEntity item : cartItemByticketRepository.findAllByCartItemById(cartItem.getId())) {
					TicketResponse ticket = new TicketResponse();
					ticket.setAmountTicket(item.getAmount());
					ticket.setIdTicket(item.getCartTicketBy().getId());
					ticket.setNote(ticketRepository.findOneById(item.getCartTicketBy().getId()).getNote());
					ticket.setTypeTicket(ticketRepository.findOneById(item.getCartTicketBy().getId()).getType());
					ticket.setValueTicket(ticketRepository.findOneById(item.getCartTicketBy().getId()).getValue());
					tickets.add(ticket);
				}
				ESMService service = esServiceRepository.findOneById(cartItem.getServiceCartItem().getId());
				response.add(
					new CartResponse(
						cartItem.getId(), 
						cartItem.getServiceCartItem().getId(),
						service.getName(),
						service.getDescription(),
						service.getImage(),
						cartItem.getBookDay(),
						cartItem.getBookTime(),
						tickets
					)
				);
			}
			return response;
		}
	}
	
	@Override
	public int totalItem() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		return cartItemRepository.findAllByCartCartItemId(cartRepository.findOneByUserCartId(userEntity.getId()).getId()).size();
	}
	
	
}
