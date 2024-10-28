package example.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import example.config.jwt.CustomUserDetails;
import example.elasticsearch.ESMService;
import example.entity.FavoriteEntity;
import example.entity.LinkDataEntity;
import example.entity.ReviewEntity;
import example.entity.ServiceEntity;
import example.entity.TicketEntity;
import example.entity.UserEntity;
import example.payload.response.FavoriteResponse;
import example.payload.response.MessageResponse;
import example.repository.ESServiceRepository;
import example.repository.FavoriteRepository;
import example.repository.LinkDataRepository;
import example.repository.ReviewRepository;
import example.repository.ServiceRepository;
import example.repository.TicketRepository;
import example.repository.UserRepository;
import example.service.IFavoriteService;


@Service
public class FavoriteService implements IFavoriteService {
	
	@Autowired
	FavoriteRepository favoriteRepository;
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	ServiceRepository serviceRepository;
	
	@Autowired
	LinkDataRepository linkDataRepository;
	
	@Autowired
	TicketRepository ticketRepository;
	
	@Autowired
	ReviewRepository reviewRepository;
	
	@Autowired
	private ESServiceRepository esRepository;
	
	@Override
	public List<FavoriteResponse> getAllFavoriteByUser() {
		
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
				
		List<FavoriteResponse> favorites = new ArrayList<>();
		List<FavoriteEntity> entities = favoriteRepository.findAllByUserFavoriteId(userEntity.getId());
		
		for (FavoriteEntity entity : entities) {
			FavoriteResponse favorite = new FavoriteResponse();
			
			ServiceEntity service = serviceRepository.findById(entity.getServiceFavorite().getId()).orElse(null);
			List<LinkDataEntity> links = linkDataRepository.findAllByServiceStorageId(service.getId());
			List<ReviewEntity> reviews = reviewRepository.findAllByServiceReviewId(service.getId(), Sort.by(Sort.Direction.ASC, "id"));
			
			
			favorite.setIdService(service.getId());
			favorite.setName(service.getName());
			favorite.setReviews(reviews.size());
			
			for (LinkDataEntity link : links) {
				if (link.getType().equals("image")) {
					favorite.setImage(link.getDataUrl());
					break;
				}
			}
			
			float totalStar = 0;
			for (int i = 0; i < reviews.size(); i++) {
				totalStar = totalStar + reviews.get(i).getPoint();
			}
			
			if (reviews.size() == 0) {
				favorite.setPointReviews(0);
			} else {
				favorite.setPointReviews(totalStar/reviews.size());
			}
			
			ESMService service1 = esRepository.findOneById(entity.getServiceFavorite().getId());
			
			favorite.setOrders(service1.getOrders());
			
			List<TicketEntity> ticketEntities = ticketRepository.findAllByServiceTicketIdOrderByValueAsc(service1.getId());
			favorite.setMinPrice(ticketEntities.get(0).getValue());
			
			favorites.add(favorite);
		}
		
		return favorites;
	}

	@Override
	@Transactional
	public List<FavoriteResponse> deleteFavorite(Long idService) {
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		favoriteRepository.deleteByUserFavoriteAndServiceFavorite(userEntity, serviceRepository.findOneById(idService));
		
		return getAllFavoriteByUser();
		
	}

	@Override
	public List<FavoriteResponse> insertFavorite(Long idService) {
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		FavoriteEntity entity = new FavoriteEntity();
		entity.setServiceFavorite(serviceRepository.findOneById(idService));
		entity.setUserFavorite(userEntity);
		
		
		FavoriteEntity response = favoriteRepository.save(entity);
		
		return getAllFavoriteByUser();
	}

	


}
