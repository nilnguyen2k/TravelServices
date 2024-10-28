package example.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import example.entity.RoleEntity;

public interface RoleRepository extends JpaRepository<RoleEntity, Long>{
	RoleEntity findOneById(Long id);
	RoleEntity findOneByRole(String name);
}
