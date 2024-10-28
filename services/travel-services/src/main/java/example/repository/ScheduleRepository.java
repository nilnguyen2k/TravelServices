package example.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import example.entity.ScheduleEntity;

public interface ScheduleRepository extends JpaRepository<ScheduleEntity, Long>{
	ScheduleEntity findOneById(Long id);
	
	List<ScheduleEntity> findAllByServiceScheduleId(Long id);
}
