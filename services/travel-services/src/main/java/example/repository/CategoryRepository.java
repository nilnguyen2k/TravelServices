package example.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import example.entity.CategoryEntity;

public interface CategoryRepository extends JpaRepository<CategoryEntity, Long> {
	CategoryEntity findOneById(Long id);
	CategoryEntity findOneByName(String name);
	List<CategoryEntity> findAll();
}
