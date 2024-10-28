package example.service.impl;
import java.util.ArrayList;
import java.util.List;

import org.elasticsearch.index.query.MultiMatchQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.SearchHit;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.data.elasticsearch.core.mapping.IndexCoordinates;
import org.springframework.data.elasticsearch.core.query.NativeSearchQuery;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.stereotype.Service;

import example.elasticsearch.ESMService;
import example.elasticsearch.model.ServiceModel;
import example.entity.ReviewEntity;
import example.repository.ESServiceRepository;
import example.repository.ReviewRepository;
import example.service.IESService;

@Service
public class ESService implements IESService {

	@Autowired
	private ESServiceRepository esRepository;
	
	@Autowired
	private ElasticsearchOperations elasticsearchOperations;
	
	@Autowired
	private ReviewRepository reviewRepo;
	
	private static final String PRODUCT_INDEX = "service";

	@Override
	public void addServiceIntoElastic(ESMService esmService) {
		esRepository.save(esmService);
	}

	@Override
	public void modifyServiceElastic(ESMService esmService) {
		esRepository.save(esmService);

	}

	@Override
	public List<ServiceModel> getAllService(Pageable pageable, Long idCategory, Long idArea, String search) {
		
		List<ServiceModel> response = new ArrayList<>();
		List<ESMService> services = new ArrayList<>();
		
		NativeSearchQuery searchQuery = null;
		
		if (!search.isEmpty()) {
			if (idCategory != 0) {
				if (idArea != 0) {
					searchQuery = new NativeSearchQueryBuilder()
							  .withQuery(QueryBuilders.multiMatchQuery(search)
							    .field("name")
							    .field("area.name")
							    .field("category.name")
							    .type(MultiMatchQueryBuilder.Type.BEST_FIELDS))
							  .withQuery(QueryBuilders.boolQuery()
									  .must(QueryBuilders.termQuery("area.id", idArea))
									  .must(QueryBuilders.termQuery("category.id", idCategory)))
							  .build();
				} else {
					searchQuery = new NativeSearchQueryBuilder()
							  .withQuery(QueryBuilders.multiMatchQuery(search)
							    .field("name")
							    .field("area.name")
							    .field("category.name")
							    .type(MultiMatchQueryBuilder.Type.BEST_FIELDS))
							  .withQuery(QueryBuilders.boolQuery().must(QueryBuilders.termQuery("category.id", idCategory)))
							  .build();
				}
			} else {
				if (idArea != 0) {
					searchQuery = new NativeSearchQueryBuilder()
							  .withQuery(QueryBuilders.multiMatchQuery(search)
							    .field("name")
							    .field("area.name")
							    .field("category.name")
							    .type(MultiMatchQueryBuilder.Type.BEST_FIELDS))
							  .withQuery(QueryBuilders.boolQuery().must(QueryBuilders.termQuery("area.id", idArea)))
							  .build();
				} else {
					searchQuery = new NativeSearchQueryBuilder()
							  .withQuery(QueryBuilders.multiMatchQuery(search)
							    .field("name")
							    .field("area.name")
							    .field("category.name")
							    .type(MultiMatchQueryBuilder.Type.BEST_FIELDS))
							  .build();
				}
			}
		} else {
			if (idCategory != 0) {
				if (idArea != 0) {
					searchQuery = new NativeSearchQueryBuilder()
							  .withQuery(QueryBuilders.boolQuery()
									  .must(QueryBuilders.termQuery("area.id", idArea))
									  .must(QueryBuilders.termQuery("category.id", idCategory)))
							  .build();	
				} else {
					searchQuery = new NativeSearchQueryBuilder()
							  .withQuery(QueryBuilders.boolQuery().must(QueryBuilders.termQuery("category.id", idCategory)))
							  .build();
				}
			} else {
				if (idArea != 0) {
					searchQuery = new NativeSearchQueryBuilder()
							  .withQuery(QueryBuilders.boolQuery().must(QueryBuilders.termQuery("area.id", idArea)))
							  .build();
				} else {
					searchQuery = new NativeSearchQueryBuilder()
							.withQuery(QueryBuilders.matchAllQuery())
							.build();
				}
			}
		}	
		
		searchQuery.setPageable(pageable);
		
		SearchHits<ESMService> data = elasticsearchOperations.search(searchQuery, ESMService.class, IndexCoordinates.of(PRODUCT_INDEX));
		
		for (SearchHit<ESMService> hit : data) {
			services.add(hit.getContent());
		}
		
		for (ESMService service : services) {
			response.add(convertToServiceModel(service));
		}

		return response;
	}

	public ServiceModel convertToServiceModel(ESMService request) {
		ServiceModel model = new ServiceModel();
		model.setId(request.getId());
		model.setAddress(request.getAddress());
		model.setArea(request.getArea());
		model.setCategory(request.getCategory());
		model.setDescription(request.getDescription());
		model.setCreateDate(request.getCreateDate());
		model.setImage(request.getImage());
		model.setModifiedDate(request.getModifiedDate());
		model.setName(request.getName());
		model.setOrders(request.getOrders());
		model.setTicket(request.getTicket());
		
		List<ReviewEntity> reviews = reviewRepo.findAllByServiceReviewId(request.getId());
		// Set reviews
		if (reviews.isEmpty()) {
			model.setReviews(0);
			model.setPoint(0);
		} else {
			float point = 0;
			for (ReviewEntity entity : reviews) {
				point = point + entity.getPoint();
			}
			model.setReviews(reviews.size());
			model.setPoint(point/reviews.size());
		}
		return model;
	}

	@Override
	public List<ServiceModel> getAllSortByOrder() {
		List<ServiceModel> response = new ArrayList<>();
		List<ESMService> services = (List<ESMService>) esRepository.findAll(Sort.by("orders").descending());
		
		if (services.size() > 20) {
			for (int i = 0; i < 20; i++) {
				response.add(convertToServiceModel(services.get(i)));
			}
		} else {
			for (int i = 0; i < services.size(); i++) {
				response.add(convertToServiceModel(services.get(i)));
			}
		}
		return response;
	}
}
