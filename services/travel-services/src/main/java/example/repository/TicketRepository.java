package example.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import example.entity.TicketEntity;

public interface TicketRepository extends JpaRepository<TicketEntity, Long>{
	List<TicketEntity> findAllByServiceTicketId(Long id);
	TicketEntity findOneById(Long id);
	List<TicketEntity> findAllByServiceTicketIdOrderByValueAsc(Long id);
}
