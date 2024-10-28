package example.service;

import example.entity.LinkDataEntity;
import example.payload.request.LinkDataRequest;
import example.payload.response.LinkDataResponse;

public interface ILinkDataService {
	LinkDataResponse saveLink(LinkDataRequest request);
	LinkDataEntity modifyLink(LinkDataResponse request, Long idService);
	String getFirstImage(Long idService);
}
