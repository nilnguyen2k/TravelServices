package example.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import example.elasticsearch.ESMService;

public interface ESServiceRepository extends ElasticsearchRepository<ESMService, Long>{
	
	ESMService findOneById(Long id);
	
//	
//	Page<ESMService> findAllByIdCategory(Long id, Pageable pageable);
//	Page<ESMService> findAllByIdArea(Long id, Pageable pageable);
//	Page<ESMService> findAllByIdAreaAndIdCategory(Long idArea, Long idCategory, Pageable pageable);
}
