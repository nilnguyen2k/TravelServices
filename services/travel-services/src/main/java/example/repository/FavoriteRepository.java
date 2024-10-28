package example.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import example.entity.FavoriteEntity;
import example.entity.ServiceEntity;
import example.entity.UserEntity;

public interface FavoriteRepository extends JpaRepository<FavoriteEntity, Long>{
	
	List<FavoriteEntity> findAllByUserFavoriteId(Long id);
	void deleteByUserFavoriteAndServiceFavorite(UserEntity user , ServiceEntity service);

}
