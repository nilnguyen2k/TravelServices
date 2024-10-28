package example.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import example.entity.ReviewEntity;

public interface ReviewRepository extends JpaRepository<ReviewEntity, Long> {
	ReviewEntity findOneById(Long id);
	List<ReviewEntity> findAllByServiceReviewId(Long id, Sort sort);
	List<ReviewEntity> findAllByServiceReviewId(Long id);
}
