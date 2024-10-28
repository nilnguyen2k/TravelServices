package example.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;

import example.entity.RefreshTokenEntity;
import example.entity.UserEntity;

public interface RefreshTokenRepository extends JpaRepository<RefreshTokenEntity, Long> {
	
	Optional<RefreshTokenEntity> findByToken(String token);
    
    @Modifying
    int deleteByUser(UserEntity user);

    
}
