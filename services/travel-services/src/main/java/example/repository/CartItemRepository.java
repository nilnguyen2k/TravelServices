package example.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import example.entity.CartItemEntity;

public interface CartItemRepository extends JpaRepository<CartItemEntity, Long> {
	CartItemEntity findOneById(Long id);
	List<CartItemEntity> findAllByCartCartItemId(Long id);
	Page<CartItemEntity> findAllByCartCartItemId(Long id, Pageable pageable);
}
