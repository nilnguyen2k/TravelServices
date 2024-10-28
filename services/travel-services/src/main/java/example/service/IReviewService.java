package example.service;

import example.entity.ReviewEntity;

public interface IReviewService {
	ReviewEntity createReview(Long idService, String content, String point); 
	ReviewEntity modifyReview(Long idReview, String content);
	void deleteReview(Long idReview);
}
