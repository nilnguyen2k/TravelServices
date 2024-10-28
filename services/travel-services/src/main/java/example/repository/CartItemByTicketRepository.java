package example.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import example.entity.CartItemByTicketEntity;

public interface CartItemByTicketRepository extends JpaRepository<CartItemByTicketEntity, Long>{
	List<CartItemByTicketEntity> findAllByCartItemById(Long id);
	CartItemByTicketEntity findOneByCartItemByIdAndCartTicketById(Long idCartItem, Long idTicket);
}
