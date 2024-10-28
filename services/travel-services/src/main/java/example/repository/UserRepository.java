package example.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import example.entity.RoleEntity;
import example.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Long>{
	UserEntity findOneById(Long id);
	UserEntity findOneByUsername(String username);
	UserEntity findOneByPhone(String phone);
	UserEntity findOneByEmail(String email);
	UserEntity findOneByResetPasswordToken(String token);
	
	List<UserEntity> findAllByRoleUser(RoleEntity role);
	
}
