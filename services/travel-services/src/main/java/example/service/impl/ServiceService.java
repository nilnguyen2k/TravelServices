package example.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import example.config.jwt.CustomUserDetails;
import example.entity.AreaEntity;
import example.entity.CategoryEntity;
import example.entity.LinkDataEntity;
import example.entity.ReviewEntity;
import example.entity.ScheduleEntity;
import example.entity.ServiceEntity;
import example.entity.TicketEntity;
import example.entity.UserEntity;
import example.payload.request.ServiceRequest;
import example.payload.response.AreaResponse;
import example.payload.response.CategoryResponse;
import example.payload.response.GetServiceByAdminResponse;
import example.payload.response.GetServiceDetailsResponse;
import example.payload.response.InforServiceDetailsResponse;
import example.payload.response.LinkDataDetailsResponse;
import example.payload.response.LinkDataResponse;
import example.payload.response.ReviewsResponse;
import example.payload.response.ScheduleResponse;
import example.payload.response.ServiceDetailsResponse;
import example.payload.response.ServiceResponse;
import example.payload.response.TicketResponse;
import example.payload.response.UserReviewResponse;
import example.repository.AreaRepository;
import example.repository.CategoryRepository;
import example.repository.LinkDataRepository;
import example.repository.ReviewRepository;
import example.repository.ScheduleRepository;
import example.repository.ServiceRepository;
import example.repository.TicketRepository;
import example.repository.UserRepository;
import example.service.IServiceService;


@Service
public class ServiceService implements IServiceService {
	
	@Autowired
	CategoryRepository categoryRepository;
	
	@Autowired
	AreaRepository areaRepository;
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	ServiceRepository serviceRepository;
	
	@Autowired
	ReviewRepository reviewRepository;
	
	@Autowired
	TicketRepository ticketRepository;
	
	@Autowired
	LinkDataRepository linkDataRepository;
	
	@Autowired
	ScheduleRepository scheduleRepo;

	@Override
	public Optional<ServiceEntity> createService(ServiceRequest request) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		CategoryEntity categoryEntity = categoryRepository.findOneById(request.getIdCategory());
		AreaEntity areaEntity = areaRepository.findOneById(request.getIdArea());
		
		ServiceEntity serviceEntity = new ServiceEntity();
		// Set data service
		serviceEntity.setAddress(request.getAddress());
		serviceEntity.setDescription(request.getDescription());
		serviceEntity.setEvent(request.getEvent());
		serviceEntity.setName(request.getName());
		serviceEntity.setNote(request.getNote());
		serviceEntity.setStatus(true);
		serviceEntity.setCategoryService(categoryEntity);
		serviceEntity.setAreaService(areaEntity);
		serviceEntity.setUserService(userEntity);
		serviceEntity.setCreateDate(new Date());
		serviceEntity.setModifiedDate(new Date());
		
		serviceEntity = serviceRepository.save(serviceEntity);
		
		return Optional.ofNullable(serviceEntity);
	}

	@Override
	public Optional<ServiceEntity> modifyService(ServiceRequest request, Long idService) {
		ServiceEntity serviceEntity = serviceRepository.findOneById(idService);
		serviceEntity.setAddress(request.getAddress());
		serviceEntity.setDescription(request.getDescription());
		serviceEntity.setEvent(request.getEvent());
		serviceEntity.setName(request.getName());
		serviceEntity.setNote(request.getNote());
		serviceEntity.setStatus(true);
		serviceEntity.setModifiedDate(new Date());
		
		serviceEntity = serviceRepository.save(serviceEntity);
		
		return Optional.ofNullable(serviceEntity);
	}

	@Override
	public ServiceDetailsResponse getServiceDetails(Long id) {
		
		ServiceDetailsResponse response = new ServiceDetailsResponse();
		
		// Set service basic
		ServiceEntity serviceEntity = serviceRepository.findOneById(id);
		response.setId(serviceEntity.getId());
		response.setAddress(serviceEntity.getAddress());
		response.setDescription(serviceEntity.getDescription());
		response.setEvent(serviceEntity.getEvent());
		response.setNote(serviceEntity.getNote());
		response.setName(serviceEntity.getName());
		response.setArea(serviceEntity.getAreaService().getName());
		response.setCategory(serviceEntity.getCategoryService().getName());
		response.setCreateByAuthId(serviceEntity.getUserService().getId());
		response.setUsernameAuth(serviceEntity.getUserService().getUsername());
		// Set list reviews
		List<ReviewEntity> reviews = reviewRepository.findAllByServiceReviewId(id, Sort.by(Sort.Direction.DESC, "id"));
		List<ReviewsResponse> reviewsResponse = new ArrayList<>();
		for (ReviewEntity review : reviews) {
			reviewsResponse.add(convertToReviewResponse(review));
		}
		response.setReviews(reviewsResponse);
		
		// Set min price
		List<TicketEntity> ticketEntities = ticketRepository.findAllByServiceTicketIdOrderByValueAsc(id);
		response.setMinPrice(ticketEntities.get(0).getValue());
		
		// Set galleries
		List<LinkDataEntity> links = linkDataRepository.findAllByServiceStorageId(id);
		List<LinkDataResponse> linksResponse = new ArrayList<>();
		for (LinkDataEntity entity : links) {
			linksResponse.add(convertToLinkDataReponse(entity));
		}
		response.setGalleries(linksResponse);
		
		return response;
	}
	
	@Override
	public ReviewsResponse convertToReviewResponse(ReviewEntity entity) {
		ReviewsResponse response = new ReviewsResponse();
		UserReviewResponse userReview = new UserReviewResponse(); 
		response.setId(entity.getId());
		response.setCreateDate(entity.getCreateDate());
		response.setModifiedDate(entity.getModifiedDate());
		response.setPoint(entity.getPoint());
		response.setContent(entity.getContent());
		
		UserEntity user = userRepository.findOneById(entity.getUserReview().getId());
		userReview.setId(user.getId());
		userReview.setAvatar(user.getAvatar());
		userReview.setFirstname(user.getFirstname());
		userReview.setLastname(user.getLastname());
		response.setUser(userReview);
		return response;
	}
	
	@Override
	public LinkDataResponse convertToLinkDataReponse(LinkDataEntity linkDataEntity) {
		LinkDataResponse response = new LinkDataResponse();
		response.setId(linkDataEntity.getId());
		response.setUrl(linkDataEntity.getDataUrl());
		response.setType(linkDataEntity.getType());
		return response;
	}

	@Override
	public List<GetServiceByAdminResponse> getAllServiceByAdmin() {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		
		List<GetServiceByAdminResponse> listResponse = new ArrayList<>();
		
		List<ServiceEntity> listService = serviceRepository.findAllByUserService(userEntity, Sort.by("id").descending());
		
		for (ServiceEntity entity : listService) {
			
			ServiceResponse serviceResponse = new ServiceResponse();
			serviceResponse.setArea(entity.getAreaService().getName());
			serviceResponse.setCategory(entity.getCategoryService().getName());
			serviceResponse.setDescription(entity.getDescription());
			serviceResponse.setEvent(entity.getEvent());
			serviceResponse.setIdService(entity.getId());
			serviceResponse.setName(entity.getName());
			
			List<LinkDataEntity> listLink = linkDataRepository.findAllByServiceStorageId(entity.getId());
			List<LinkDataResponse> links = new ArrayList<>();
			for (LinkDataEntity link : listLink) {
				LinkDataResponse linkResponse = new LinkDataResponse();
				linkResponse.setId(link.getId());
				linkResponse.setType(link.getType());
				linkResponse.setUrl(link.getDataUrl());
				links.add(linkResponse);
			}
			
			List<ScheduleEntity> listSchedule = scheduleRepo.findAllByServiceScheduleId(entity.getId());
			List<ScheduleResponse> schedules = new ArrayList<>();
			for (ScheduleEntity schedule : listSchedule) {
				ScheduleResponse scheduleResponse = new ScheduleResponse();
				scheduleResponse.setId(schedule.getId());
				scheduleResponse.setQuantityPerDay(schedule.getQuantityperday());
				scheduleResponse.setTime(schedule.getTime());
				schedules.add(scheduleResponse);
			}
			
			List<TicketEntity> listTicket = ticketRepository.findAllByServiceTicketId(entity.getId());
			List<TicketResponse> tickets = new ArrayList<>();
			for (TicketEntity ticket : listTicket) {
				TicketResponse ticketResponse = new TicketResponse();
				ticketResponse.setIdTicket(ticket.getId());
				ticketResponse.setTypeTicket(ticket.getType());
				ticketResponse.setValueTicket(ticket.getValue());
				ticketResponse.setAmountTicket(ticket.getAmount());
				ticketResponse.setNote(ticket.getNote());
				tickets.add(ticketResponse);
			}
			
			
			GetServiceByAdminResponse response = new GetServiceByAdminResponse();
			response.setService(serviceResponse);
			response.setGalleries(links);
			response.setSchedule(schedules);
			response.setTicket(tickets);
			// Set value
			listResponse.add(response);
		}
		
		return listResponse;
	}

	@Override
	public GetServiceDetailsResponse getServiceDetailss(Long idService) {
		
		ServiceEntity service = serviceRepository.findOneById(idService);
		
		InforServiceDetailsResponse infor = new InforServiceDetailsResponse();
		
		CategoryResponse cate = new CategoryResponse();
		cate.setId(service.getCategoryService().getId());
		cate.setName(service.getCategoryService().getName());
		cate.setIcon(service.getCategoryService().getIcon());
		
		AreaResponse are = new AreaResponse(); 
		are.setId(service.getAreaService().getId());
		are.setName(service.getAreaService().getName());
		are.setUrl(service.getAreaService().getDataUrl());
		
		infor.setId(service.getId());
		infor.setName(service.getName());
		infor.setDescription(service.getDescription());
		infor.setEvent(service.getEvent());
		infor.setAddress(service.getAddress());
		infor.setNote(service.getNote());
		infor.setCategory(cate);
		infor.setArea(are);
		
		List<LinkDataEntity> listLink = linkDataRepository.findAllByServiceStorageId(idService);
		List<LinkDataDetailsResponse> links = new ArrayList<>();
		for (LinkDataEntity link : listLink) {
			LinkDataDetailsResponse linkResponse = new LinkDataDetailsResponse();
			linkResponse.setId(link.getId());
			linkResponse.setType(link.getType());
			linkResponse.setUrl(link.getDataUrl());
			linkResponse.setPublicId(link.getPublicId());
			links.add(linkResponse);
		}
		
		List<ScheduleEntity> listSchedule = scheduleRepo.findAllByServiceScheduleId(idService);
		List<ScheduleResponse> schedules = new ArrayList<>();
		for (ScheduleEntity schedule : listSchedule) {
			ScheduleResponse scheduleResponse = new ScheduleResponse();
			scheduleResponse.setId(schedule.getId());
			scheduleResponse.setQuantityPerDay(schedule.getQuantityperday());
			scheduleResponse.setTime(schedule.getTime());
			schedules.add(scheduleResponse);
		}
		
		List<TicketEntity> listTicket = ticketRepository.findAllByServiceTicketId(idService);
		List<TicketResponse> tickets = new ArrayList<>();
		for (TicketEntity ticket : listTicket) {
			TicketResponse ticketResponse = new TicketResponse();
			ticketResponse.setIdTicket(ticket.getId());
			ticketResponse.setTypeTicket(ticket.getType());
			ticketResponse.setValueTicket(ticket.getValue());
			ticketResponse.setAmountTicket(ticket.getAmount());
			ticketResponse.setNote(ticket.getNote());
			tickets.add(ticketResponse);
		}
		
		GetServiceDetailsResponse response = new GetServiceDetailsResponse();
		response.setService(infor);
		response.setGalleries(links);
		response.setSchedule(schedules);
		response.setTicket(tickets);
		return response;
	}
	
}
