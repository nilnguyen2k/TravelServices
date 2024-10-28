package example.api;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import example.payload.request.ProfileUpdateRequest;
import example.payload.response.MessageResponse;
import example.payload.response.ProfileUserResponse;
import example.service.impl.UserService;

@CrossOrigin
@RestController
public class ProfileAPI {
	
	@Autowired
	Cloudinary cloudinary;
	
	@Autowired
	UserService userService;
	
	@GetMapping(value = "/user/profile")
	public ProfileUserResponse getProfileUser() {
		ProfileUserResponse response = new ProfileUserResponse();
		
		response.setInfor(userService.getProfile());
		response.setNumOrderWaiting(userService.totalOrderItemsStatusForUser("waiting"));
		response.setNumOrderApproved(userService.totalOrderItemsStatusForUser("approved"));
		response.setNumOrderExperienced(userService.totalOrderItemsStatusForUser("experienced"));
		
		response.setNumOrderForAdmin(userService.totalOrderForAdmin());
		response.setNumServiceForAdmin(userService.totalServiceForAdmin());
		
		return response;
	}
	
	@PutMapping(value = "/user/profile")
	public ProfileUserResponse updateProfileUser(@RequestBody ProfileUpdateRequest request) {
		ProfileUserResponse response = new ProfileUserResponse();
		response.setInfor(userService.updateProfile(request));
		response.setNumOrderWaiting(userService.totalOrderItemsStatusForUser("waiting"));
		response.setNumOrderApproved(userService.totalOrderItemsStatusForUser("approved"));
		response.setNumOrderExperienced(userService.totalOrderItemsStatusForUser("experienced"));
		
		response.setNumOrderForAdmin(userService.totalOrderForAdmin());
		response.setNumServiceForAdmin(userService.totalServiceForAdmin());
		
		return response;
	}
	
	@PostMapping(value = "/avatar/upload")
	public Object updateAvatar(@RequestPart MultipartFile file) {
		try {
			
			Map upload = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.asMap("resource_type", "auto"));
			
			ProfileUserResponse response = new ProfileUserResponse();
			response.setInfor(userService.updateAvatar(upload.get("secure_url").toString()));
			response.setNumOrderWaiting(userService.totalOrderItemsStatusForUser("waiting"));
			response.setNumOrderApproved(userService.totalOrderItemsStatusForUser("approved"));
			response.setNumOrderExperienced(userService.totalOrderItemsStatusForUser("experienced"));
			
			return response;
			
		} catch (IOException e) {
			e.printStackTrace();
			return new MessageResponse("Failed");
		}
	}
	
//	@GetMapping(value = "/user/orderitem")
//	public 
	
	
	
	
}
