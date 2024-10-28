package example.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import example.elasticsearch.ESMService;
import example.elasticsearch.model.ServiceModel;

public interface IESService {
	
	void addServiceIntoElastic(ESMService esmService);
	
	void modifyServiceElastic(ESMService esmServvice);
	
	// Search
	List<ServiceModel> getAllService(Pageable pageable, Long idCategory, Long idArea, String search);
	
	List<ServiceModel> getAllSortByOrder();
}
