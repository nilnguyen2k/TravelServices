package example.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import example.entity.CartEntity;

public interface CartRepository extends JpaRepository<CartEntity, Long> {
	CartEntity findOneByUserCartId(Long id);
}
