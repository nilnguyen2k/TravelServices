package example.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import example.config.jwt.CustomUserDetails;
import example.entity.OrderEntity;
import example.entity.OrderItemEntity;
import example.entity.RoleEntity;
import example.entity.ServiceEntity;
import example.entity.UserEntity;
import example.exception.UserNotFoundException;
import example.payload.request.ProfileUpdateRequest;
import example.payload.request.RegisterRequest;
import example.payload.response.MessageResponse;
import example.payload.response.ProfileResponse;
import example.payload.response.RegisterResponse;
import example.payload.response.RegisterResponseStatus;
import example.repository.OrderItemRepository;
import example.repository.OrderRepository;
import example.repository.RoleRepository;
import example.repository.ServiceRepository;
import example.repository.UserRepository;
import example.service.IUserService;

@Service
public class UserService implements IUserService, UserDetailsService {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private RoleRepository roleRepository;
	
	@Autowired
	private OrderRepository orderRepository;
	
	@Autowired
	private OrderItemRepository orderItemRepository;
	
	@Autowired
	private ServiceRepository serviceRepository;

	@Override
	public RegisterResponseStatus createUser(RegisterRequest request) {
		
		String female = "https://res.cloudinary.com/nilnguyen/image/upload/v1667472751/TravelServiceDefault/woman-avatar_nkoqe3.png";
		String male = "https://res.cloudinary.com/nilnguyen/image/upload/v1667472751/TravelServiceDefault/male-user_idplqw.png";
		
		UserEntity user1 = userRepository.findOneByUsername(request.getUsername());
		
		if (user1 != null) {
			return new RegisterResponseStatus(new MessageResponse("Account already exists"), "Failed");
		} else {
			
			RoleEntity roleEntity = roleRepository.findOneById(request.getIdRole());
			UserEntity entity = new UserEntity();
			entity.setUsername(request.getUsername());
			entity.setEmail(request.getEmail());
			entity.setFirstname(request.getFirstname());
			entity.setLastname(request.getLastname());
			entity.setPassword(request.getPassword());
			entity.setSex(request.getSex());
			entity.setPhone(request.getPhone());
			entity.setAvatar(request.getSex() == "Female" ? female : male);
			entity.setRoleUser(roleEntity);
			entity.setPassword(new BCryptPasswordEncoder().encode(entity.getPassword()));
			entity.setCreateDate(new Date());
			entity.setModifiedDate(new Date());
			entity.setProvider(request.isProvider());
			// Save to database
			entity = userRepository.save(entity);
			
			
			return new RegisterResponseStatus(convertToRegisterResponse(entity), "Success");
			
		}
	}
	
	@Override
	@Transactional
    public UserDetails loadUserByUsername(String username) {
        UserEntity user = userRepository.findOneByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException(username);
        }
        return CustomUserDetails.build(user);
    }

	@Override
	public void updateResetPasswordToken(String token, String email) {
		UserEntity user = userRepository.findOneByEmail(email);
		if (user != null) {
			user.setResetPasswordToken(token);
			userRepository.save(user);
		} else {
			new UserNotFoundException("Could not find any user with the email " + email);
		}
		
	}

	@Override
	public void updatePassword(UserEntity user, String newPassword) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String encodedPassword = passwordEncoder.encode(newPassword);
		user.setPassword(encodedPassword);
		user.setResetPasswordToken(null);
		userRepository.save(user);
	}

	@Override
	public UserEntity getByResetPasswordToken(String token) {
		return userRepository.findOneByResetPasswordToken(token);
	}

	@Override
	public ProfileResponse getProfile() {
		ProfileResponse response = new ProfileResponse();
		
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		response.setAvatar(userEntity.getAvatar());
		response.setEmail(userEntity.getEmail());
		response.setFirstname(userEntity.getFirstname());
		response.setLastname(userEntity.getLastname());
		response.setId(userEntity.getId());
		response.setPhone(userEntity.getPhone());
		response.setSex(userEntity.getSex());
		response.setRole(userEntity.getRoleUser().getRole());
		
		return response;
	}
	
//	@Override
//	public int totalOrder() {
//		// Authentication
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
//		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
//		
//		return orderRepository.findAllByUserOrderId(userEntity.getId()).size();
//	}

	@Override
	public RegisterResponse convertToRegisterResponse(UserEntity user) {
		RegisterResponse response = new RegisterResponse();
		response.setId(user.getId());
		response.setUsername(user.getUsername());
		response.setAvatar(user.getAvatar());
		response.setEmail(user.getEmail());
		response.setFirstname(user.getFirstname());
		response.setLastname(user.getLastname());
		response.setPhone(user.getPhone());
		response.setSex(user.getSex());
		response.setRole(user.getRoleUser().getRole());
		response.setCreateDate(new Date());
		response.setModifiedDate(new Date());
		return response;
	}

	@Override
	public int totalOrderItemsStatusForUser(String status) {
		
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		List<OrderEntity> listOrder = orderRepository.findAllByUserOrderId(userEntity.getId());
		
		int total = 0;
		
		for (OrderEntity order : listOrder) {
			List<OrderItemEntity> items = orderItemRepository.findAllByOrderOrderItemAndStatus(order, status);
			total = total + items.size();
		}
		
		return total;
	
	}

	@Override
	public ProfileResponse updateProfile(ProfileUpdateRequest request) {
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		userEntity.setFirstname(request.getFirstname());
		userEntity.setLastname(request.getLastname());
		userEntity.setEmail(request.getEmail());
		userEntity.setSex(request.getGender());
		userEntity.setModifiedDate(new Date());
		
		userEntity = userRepository.save(userEntity);
		
		return getProfile();
		
	}

	@Override
	public ProfileResponse updateAvatar(String avatar) {
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		userEntity.setAvatar(avatar);
		
		UserEntity response = userRepository.save(userEntity);
		
		return getProfile();
	}

	@Override
	public int totalOrderForAdmin() {
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		List<ServiceEntity> services = serviceRepository.findAllByUserService(userEntity);
		
		if (services == null) {
			return 0;
		} else {
			int total = 0;
			for (int i = 0; i < services.size(); i++) {
				List<OrderItemEntity> orders = orderItemRepository.findAllByServiceOrderItem(services.get(i));
				if (orders != null) {
					total = total + orders.size();
				}
			}
			return total;
		}
	}

	@Override
	public int totalServiceForAdmin() {
		// Authentication
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		UserEntity userEntity = userRepository.findOneByUsername(userDetails.getUsername());
		
		List<ServiceEntity> services = serviceRepository.findAllByUserService(userEntity);
		System.out.println("===========" + services.size());
		if (services == null) {
			return 0;
		} else {
			return services.size();
		}
	}
}
