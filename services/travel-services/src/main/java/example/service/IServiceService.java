package example.service;

import java.util.List;
import java.util.Optional;

import example.entity.LinkDataEntity;
import example.entity.ReviewEntity;
import example.entity.ServiceEntity;
import example.payload.request.ServiceRequest;
import example.payload.response.GetServiceByAdminResponse;
import example.payload.response.GetServiceDetailsResponse;
import example.payload.response.LinkDataResponse;
import example.payload.response.ReviewsResponse;
import example.payload.response.ServiceDetailsResponse;

public interface IServiceService {
	Optional<ServiceEntity> createService(ServiceRequest request);
	Optional<ServiceEntity> modifyService(ServiceRequest request, Long idService);
	ServiceDetailsResponse getServiceDetails(Long id);
	ReviewsResponse convertToReviewResponse(ReviewEntity entity);
	LinkDataResponse convertToLinkDataReponse(LinkDataEntity linkDataEntity);
	
	List<GetServiceByAdminResponse> getAllServiceByAdmin();
	
	GetServiceDetailsResponse getServiceDetailss(Long idService);
}
