package example.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import example.entity.OrderItemByTicketEntity;

public interface OrderItemByTicketRepository extends JpaRepository<OrderItemByTicketEntity, Long>{
	List<OrderItemByTicketEntity> findAllByOrderItemById(Long id);
}
