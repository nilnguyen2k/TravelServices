package example.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import example.entity.LinkDataEntity;

public interface LinkDataRepository extends JpaRepository<LinkDataEntity, Long>{
	LinkDataEntity findOneById(Long id);
	List<LinkDataEntity> findAllByServiceStorageId(Long id);
}
