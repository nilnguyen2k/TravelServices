package example.service;

import example.entity.UserEntity;
import example.payload.request.ProfileUpdateRequest;
import example.payload.request.RegisterRequest;
import example.payload.response.ProfileResponse;
import example.payload.response.RegisterResponse;
import example.payload.response.RegisterResponseStatus;

public interface IUserService {
	RegisterResponseStatus createUser(RegisterRequest userDTO);
	RegisterResponse convertToRegisterResponse(UserEntity user);
	void updateResetPasswordToken(String token, String email);
	void updatePassword(UserEntity user, String newPassword);
	UserEntity getByResetPasswordToken(String token);
	ProfileResponse getProfile();
	int totalOrderItemsStatusForUser(String status);
	ProfileResponse updateProfile(ProfileUpdateRequest request);
	
	ProfileResponse updateAvatar(String avartar);
	
	int totalOrderForAdmin();
	int totalServiceForAdmin();
	// int totalOrder();
}
