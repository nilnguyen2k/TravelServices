package example.api;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import example.config.jwt.CustomUserDetails;
import example.config.jwt.JwtTokenProvider;
import example.entity.RefreshTokenEntity;
import example.entity.UserEntity;
import example.exception.TokenRefreshException;
import example.payload.request.ChangePasswordRequest;
import example.payload.request.ForgotPasswordRequest;
import example.payload.request.LoginRequest;
import example.payload.request.RegisterRequest;
import example.payload.request.ResetPasswordRequest;
import example.payload.request.TokenRefreshRequest;
import example.payload.response.ForgotPasswordResponse;
import example.payload.response.LoginResponse;
import example.payload.response.MessageResponse;
import example.payload.response.RegisterResponseStatus;
import example.payload.response.TokenRefreshResponse;
import example.repository.UserRepository;
import example.service.IUserService;
import example.service.impl.RefreshTokenService;
import net.bytebuddy.utility.RandomString;

@CrossOrigin
@RestController
public class AuthAPI {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private IUserService userService;

	@Autowired
	RefreshTokenService refreshTokenService;

	@Autowired
	private JwtTokenProvider tokenProvider;

	@Autowired
	AuthenticationManager authenticationManager;

	@PostMapping(value = "/auth/register")
	public RegisterResponseStatus createUser(@RequestBody RegisterRequest model) {
		return userService.createUser(model);
	}

	@PostMapping("/auth/login")
	public LoginResponse authenticateUser(@RequestBody LoginRequest loginRequest) {
		Authentication authentication = authenticationManager.authenticate(
				new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));
		SecurityContextHolder.getContext().setAuthentication(authentication);

		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity user = userRepository.findOneById(userDetails.getId());
		String jwt = tokenProvider.generateJwtToken(userDetails);
		List<String> roles = userDetails.getAuthorities().stream().map(item -> item.getAuthority())
				.collect(Collectors.toList());
		RefreshTokenEntity refreshToken = refreshTokenService.createRefreshToken(userDetails.getId());
		return new LoginResponse(jwt, refreshToken.getToken(), userDetails.getId(), userDetails.getUsername(), user.getPhone(),
				userDetails.getEmail(), roles, user.isProvider());
	}
	
	@PostMapping("/auth/changepassword")
	public MessageResponse changePassword(@RequestBody ChangePasswordRequest request) {
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		UserEntity entity = userRepository.findOneByUsername(request.getUsername());
		boolean isCorrect = encoder.matches(request.getOldPassword(), entity.getPassword());
		
		if (isCorrect) {
			entity.setPassword(encoder.encode(request.getNewPassword()));
			entity = userRepository.save(entity);
			if (entity != null) {
				return new MessageResponse("Success");
			} else {
				return new MessageResponse("Something was wrong");
			}
		} else {
			return new MessageResponse("Password incorrect");
		}
	}

	@PostMapping("/auth/refreshtoken")
	public ResponseEntity<?> refreshtoken(@RequestBody TokenRefreshRequest request) {
		String requestRefreshToken = request.getRefreshToken();
		return refreshTokenService.findByToken(requestRefreshToken)
				.map(refreshTokenService::verifyExpiration)
				.map(RefreshTokenEntity::getUser).map(user -> {
					String token = tokenProvider.generateTokenFromUsername(user.getUsername());
					return ResponseEntity.ok(new TokenRefreshResponse(token, requestRefreshToken));
				})
				.orElseThrow(() -> new TokenRefreshException(requestRefreshToken, "Refresh token is not in database!"));
	}
	
	@PostMapping("/auth/forgotpassword")
	public ForgotPasswordResponse forgotPassword(@RequestBody ForgotPasswordRequest request) {
	    String token = RandomString.make(30);
	    userService.updateResetPasswordToken(token, request.getEmail());
	   
	    return new ForgotPasswordResponse(token);
    }
	
	@PostMapping("/auth/resetpassword")
	public String resetPassword(@RequestBody ResetPasswordRequest request) {
		UserEntity user = userService.getByResetPasswordToken(request.getToken());
		if (user == null) {
			return "failed";
		} else {
			userService.updatePassword(user, request.getNewPassword());
			return "Success";
		}
	}
	
}
