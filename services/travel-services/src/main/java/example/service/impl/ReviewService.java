package example.service.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import example.config.jwt.CustomUserDetails;
import example.entity.ReviewEntity;
import example.entity.UserEntity;
import example.repository.ReviewRepository;
import example.repository.ServiceRepository;
import example.repository.UserRepository;
import example.service.IReviewService;

@Service
public class ReviewService implements IReviewService {
	
	@Autowired
	ReviewRepository reviewRepository;
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	ServiceRepository serviceRepository;
	
	@Override
	public ReviewEntity createReview(Long idService, String content, String point) {
		ReviewEntity reviewEntity = new ReviewEntity();
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		reviewEntity.setContent(content);
		reviewEntity.setCreateDate(new Date());
		reviewEntity.setServiceReview(serviceRepository.findOneById(idService));
		reviewEntity.setPoint(Float.parseFloat(point));
		reviewEntity.setModifiedDate(new Date());
		reviewEntity.setUserReview(userEntity);
		
		reviewRepository.save(reviewEntity);
		
		return reviewEntity;
	}

	@Override
	public ReviewEntity modifyReview(Long idReview, String content) {
		ReviewEntity reviewEntity = reviewRepository.findOneById(idReview);
		reviewEntity.setContent(content);
		reviewEntity.setCreateDate(new Date());
		reviewEntity.setModifiedDate(new Date());
		reviewRepository.save(reviewEntity);
		return reviewEntity;
	}

	@Override
	public void deleteReview(Long idReview) {
		reviewRepository.deleteById(idReview);
	}

}
