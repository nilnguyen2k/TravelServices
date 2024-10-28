package example.api;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import example.elasticsearch.ESMService;
import example.entity.LinkDataEntity;
import example.entity.ServiceEntity;
import example.exception.ServiceException;
import example.payload.request.CreateServiceRequest;
import example.payload.request.LinkDataRequest;
import example.payload.request.ModifyServiceRequest;
import example.payload.request.ScheduleRequest;
import example.payload.request.TicketRequest;
import example.payload.response.GetServiceByAdminResponse;
import example.payload.response.GetServiceDetailsResponse;
import example.payload.response.LinkDataDetailsResponse;
import example.payload.response.LinkDataResponse;
import example.payload.response.MessageResponse;
import example.payload.response.ScheduleResponse;
import example.payload.response.TicketResponse;
import example.repository.AreaRepository;
import example.repository.CategoryRepository;
import example.repository.ESServiceRepository;
import example.repository.LinkDataRepository;
import example.service.impl.AreaService;
import example.service.impl.CategoryService;
import example.service.impl.ESService;
import example.service.impl.LinkDataService;
import example.service.impl.ScheduleService;
import example.service.impl.ServiceService;
import example.service.impl.TicketService;

@CrossOrigin
@RestController
public class ServiceAPI {

	@Autowired
	ESService esService;

	@Autowired
	ServiceService serviceService;

	@Autowired
	TicketService ticketService;
	
	@Autowired
	AreaService areaService;
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	ScheduleService scheduleService;
	
	@Autowired
	LinkDataService linkDataService;
	
	@Autowired
	LinkDataRepository linkDataRepository; 
	
	@Autowired
	AreaRepository areaRepository; 
	
	@Autowired
	CategoryRepository categoryRepository; 

	@Autowired
	Cloudinary cloudinary;
	
	@Autowired
	ESServiceRepository esServiceRepository;
	
	@PostMapping(value = "/admin/upload")
	public List<LinkDataResponse> uploadData(@RequestPart MultipartFile[] files) {
		List<LinkDataResponse> listLink = new ArrayList<>();
		Arrays.asList(files).stream().forEach(file -> {
			try {
				Map upload = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.asMap("resource_type", "auto"));
				LinkDataResponse link = linkDataService.saveLink(new LinkDataRequest(upload.get("secure_url").toString(), upload.get("resource_type").toString(), upload.get("public_id").toString()));
				listLink.add(link);
			} catch (IOException e) {
				e.printStackTrace();
			}
		});
		return listLink;
	}
	
	@DeleteMapping(value = "/admin/delete/{idLink}")
	public ResponseEntity<List<LinkDataDetailsResponse>> deleteData(@PathVariable("idLink") String id, @RequestParam String publicId, @RequestParam String idService) {
		LinkDataEntity linkDataEntity = linkDataRepository.findOneById(Long.parseLong(id));
		try {
			if (linkDataEntity.getType().equals("image")) {
				cloudinary.uploader().destroy(publicId, ObjectUtils.asMap("resource_type", "image"));
			}
			if (linkDataEntity.getType().equals("video")) {
				cloudinary.uploader().destroy(publicId, ObjectUtils.asMap("resource_type", "video"));
			}
			linkDataRepository.deleteById(Long.parseLong(id));
		} catch (IOException e) {
			throw new ServiceException("Can not delete data");
		}
		
		List<LinkDataDetailsResponse> listResponse = new ArrayList<>();
		List<LinkDataEntity> links = linkDataRepository.findAllByServiceStorageId(Long.parseLong(idService));
		
		for (LinkDataEntity entity : links) {
			LinkDataDetailsResponse response = new LinkDataDetailsResponse();
			response.setId(entity.getId());
			response.setPublicId(entity.getPublicId());
			response.setType(entity.getType());
			response.setUrl(entity.getDataUrl());
			listResponse.add(response);
		}
		return ResponseEntity.ok(listResponse);
	}
	
	@PostMapping(value = "/admin/service")
	public ResponseEntity<?> createProduct(@RequestBody CreateServiceRequest request) {
		ServiceEntity serviceEntity = serviceService.createService(request.getService()).orElse(null);
		if (serviceEntity != null) {
			List<String> listImgUrl = new ArrayList<>();
			if (request.getTicket() != null) {
				for (TicketRequest ticketRequest : request.getTicket()) {
					ticketService.createTicket2(ticketRequest, serviceEntity.getId());
				}
			}
			for (LinkDataResponse linkRequest : request.getGalleries()) {
				linkDataService.modifyLink(linkRequest, serviceEntity.getId());
				if (linkRequest.getType().equals("image")) {
					listImgUrl.add(linkRequest.getUrl());
				}
			}
			if (request.getSchedule() != null) {
				for (ScheduleRequest scheduleRequest : request.getSchedule()) {
					scheduleService.createSchedule2(scheduleRequest, serviceEntity.getId());
				}
			}
			
			// Add elastich search
			ESMService esmService = new ESMService();
			esmService.setId(serviceEntity.getId());
			esmService.setName(serviceEntity.getName());
			esmService.setDescription(serviceEntity.getDescription());
			esmService.setImage(listImgUrl.get(0));
			esmService.setTicket(ticketService.convertToESMTicket(serviceEntity.getId()));
			esmService.setReviews(0);
			esmService.setOrders(0);
			esmService.setArea(areaService.convertToESMArea(areaRepository.findOneById(serviceEntity.getAreaService().getId())));
			esmService.setCategory(categoryService.convertToESMCategory(categoryRepository.findOneById(serviceEntity.getCategoryService().getId())));
			esmService.setCreateDate(serviceEntity.getCreateDate());
			esmService.setModifiedDate(serviceEntity.getModifiedDate());
			esmService.setSchedule(scheduleService.convertToESMSchedule(serviceEntity.getId()));
			esmService.setAddress(serviceEntity.getAddress());
			esService.addServiceIntoElastic(esmService);
			return ResponseEntity.ok(new MessageResponse("Success"));
		}
		throw new ServiceException("Can not create service");
	}
	
	
	@PutMapping(value = "/admin/service/{idService}")
	public ResponseEntity<?> modifyProduct(@PathVariable("idService") String id, @RequestBody ModifyServiceRequest request) {
		ServiceEntity serviceEntity = serviceService.modifyService(request.getService(), Long.parseLong(id)).orElse(null);
		if (serviceEntity != null) {
			if (request.getTicket() != null) {
				for (TicketResponse ticketRequest : request.getTicket()) {
					ticketService.modifyTicket(ticketRequest);
				}
			}
			if (request.getGalleries() != null) {
				for (LinkDataResponse linkRequest : request.getGalleries()) {
					linkDataService.modifyLink(linkRequest, serviceEntity.getId());
				}
			}
			if (request.getSchedule() != null) {
				for (ScheduleResponse scheduleRequest : request.getSchedule()) {
					scheduleService.modifySchedule(scheduleRequest);
				}
			}
			
			ESMService esmService = esServiceRepository.findOneById(Long.parseLong(id));
			esmService.setName(serviceEntity.getName());
			esmService.setDescription(serviceEntity.getDescription());
			esmService.setImage(linkDataService.getFirstImage(Long.parseLong(id)));
			esmService.setTicket(ticketService.convertToESMTicket(serviceEntity.getId()));
			esmService.setSchedule(scheduleService.convertToESMSchedule(serviceEntity.getId()));
			esmService.setModifiedDate(serviceEntity.getModifiedDate());
			esService.modifyServiceElastic(esmService);
			// Update elasticsearch
			
			return ResponseEntity.ok(new MessageResponse("Success"));
		}
		throw new ServiceException("Can not modify service");
	}
	
	@GetMapping(value = "/admin/service")
	public List<GetServiceByAdminResponse> getAllServiceByAdmin() {
		return serviceService.getAllServiceByAdmin();
	}
	
	@GetMapping(value = "/admin/serviceDetails")
	public GetServiceDetailsResponse getServiceDetails(@RequestParam("idService") String idService) {
		return serviceService.getServiceDetailss(Long.parseLong(idService));
	}
}
