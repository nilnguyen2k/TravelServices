package example.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import example.entity.ReviewEntity;
import example.payload.response.MessageResponse;
import example.service.impl.ReviewService;

@CrossOrigin
@RestController
public class ReviewAPI {
	
	@Autowired
	ReviewService reviewService;
	
	@PostMapping(value = "/customer/review")
	public MessageResponse createReview(@RequestParam long idService, @RequestParam String content, @RequestParam String point) {
		ReviewEntity reviewEntity = reviewService.createReview(idService, content, point);
		if (reviewEntity != null) {
			return new MessageResponse("Success");
		} else {
			return new MessageResponse("Failed");
		}
	}
	
	@PutMapping(value = "/customer/review/{idReview}")
	public MessageResponse modifyReview(@PathVariable("idReview") String id, @RequestParam String content) {
		ReviewEntity reviewEntity = reviewService.modifyReview(Long.parseLong(id), content);
		if (reviewEntity != null) {
			return new MessageResponse("Success");
		} else {
			return new MessageResponse("Failed");
		}
	}
	
	@DeleteMapping(value = "/customer/review/{idReview}")
	public MessageResponse deleteReview(@PathVariable("idReview") String id) {
		reviewService.deleteReview(Long.parseLong(id));
		return new MessageResponse("Success");
	}
	
}
