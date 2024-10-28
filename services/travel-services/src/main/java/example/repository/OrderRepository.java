package example.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import example.entity.OrderEntity;

public interface OrderRepository extends JpaRepository<OrderEntity, Long>{
	OrderEntity findOneById(Long id);
	Page<OrderEntity> findByUserOrderId(Long id, Pageable pageable);
	List<OrderEntity> findAllByUserOrderId(Long id);
	
	List<OrderEntity> findByUserOrderId(Long id);
}
