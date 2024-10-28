package example.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import example.entity.ServiceEntity;
import example.entity.UserEntity;

public interface ServiceRepository extends JpaRepository<ServiceEntity, Long>{
	ServiceEntity findOneById(Long id);
	List<ServiceEntity> findAllByUserService(UserEntity user, Sort sort);
	
	List<ServiceEntity> findAllByUserService(UserEntity user);
}
