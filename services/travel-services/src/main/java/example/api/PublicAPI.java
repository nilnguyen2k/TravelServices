package example.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import example.elasticsearch.model.ServiceModel;
import example.payload.response.AbloutAppResponse;
import example.payload.response.AreaResponse;
import example.payload.response.CategoryResponse;
import example.payload.response.FavoriteAreaResponse;
import example.payload.response.GetServiceResponse;
import example.payload.response.ServiceDetailsResponse;
import example.repository.OrderItemRepository;
import example.repository.RoleRepository;
import example.repository.ServiceRepository;
import example.repository.UserRepository;
import example.service.impl.AreaService;
import example.service.impl.CategoryService;
import example.service.impl.ESService;
import example.service.impl.ServiceService;

@CrossOrigin
@RestController
public class PublicAPI {

	@Autowired
	ESService esService;
	
	@Autowired
	AreaService areaService;
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	ServiceService serviceService;
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	RoleRepository roleRepository;
	
	@Autowired
	OrderItemRepository orderitemRepository;
	
	@Autowired
	ServiceRepository serviceRepository;

	@GetMapping(value = "/public/service")
	public GetServiceResponse getService(
			
			@RequestParam("page") int page, 
			@RequestParam("limit") int limit,
			@RequestParam(value = "sort", defaultValue = "Default") String sort, 
			@RequestParam(value = "search", defaultValue = "") String search,
			@RequestParam(value = "area", defaultValue = "0") Long idArea,
			@RequestParam(value = "category", defaultValue = "0") Long idCategory) {

		GetServiceResponse response = new GetServiceResponse();
		response.setPage(page);
		
		Pageable pageable = null;
		Sort sortable = null;
		
		if (sort.equals("AscOrders")) {
			sortable = Sort.by("orders").ascending();
			pageable = PageRequest.of(page - 1, limit, sortable);
		}
		
		if (sort.equals("DescOrders")) {
			sortable = Sort.by("orders").descending();
			pageable = PageRequest.of(page - 1, limit, sortable);
		}
		
		if (sort.equals("AscReviews")) {
			sortable = Sort.by("reviews").ascending();
			pageable = PageRequest.of(page - 1, limit, sortable);
		}
		
		if (sort.equals("DescReviews")) {
			sortable = Sort.by("reviews").descending();
			pageable = PageRequest.of(page - 1, limit, sortable);
		}
		
		if (sort.equals("Default")) {
			pageable = PageRequest.of(page - 1, limit);
		}
		
		response.setItems(esService.getAllService(pageable, idCategory, idArea, search));
		response.setTotalPage((int)Math.ceil((double)response.getItems().size() / limit));
		
		return response;

	}
	
	
	@GetMapping(value = "/public/area")
	public List<AreaResponse> getAllArea() {
		return areaService.getAllArea();
	}
	
	@GetMapping(value = "/public/category")
	public List<CategoryResponse> getAllCategory() {
		return categoryService.getAllCategory();
	}
	
	@GetMapping(value = "/public/serviceDetails")
	public ServiceDetailsResponse getServiceDetails(@RequestParam(value = "idService") Long idService) {
		return serviceService.getServiceDetails(idService);
	}
	
	@GetMapping(value = "/public/about")
	public AbloutAppResponse getAboutApp() {
		AbloutAppResponse response = new AbloutAppResponse(); 
		
		response.setNumUser(userRepository.findAllByRoleUser(roleRepository.findOneByRole("USER")).size());
		response.setNumAdmin(userRepository.findAllByRoleUser(roleRepository.findOneByRole("ADMIN")).size());
		response.setNumService(serviceRepository.findAll().size());
		response.setNumOrder(orderitemRepository.findAll().size());
		
		return response; 
	}
	
	@GetMapping(value = "/public/favoriteArea")
	public List<FavoriteAreaResponse> getFavoriteArea() {
		return areaService.getFavoriteAreaResponse();
	}
	
	@GetMapping(value = "/public/favoriteService")
	public List<ServiceModel> getFavoriteService() {
		return esService.getAllSortByOrder();
	}
	
	
}
