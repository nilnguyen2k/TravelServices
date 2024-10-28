package example.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloudinary.Cloudinary;

import example.entity.LinkDataEntity;
import example.payload.request.LinkDataRequest;
import example.payload.response.LinkDataResponse;
import example.repository.LinkDataRepository;
import example.repository.ServiceRepository;
import example.service.ILinkDataService;

@Service
public class LinkDataService implements ILinkDataService {
	
	@Autowired
	LinkDataRepository linkDataRepository;
	
	@Autowired
	ServiceRepository serviceRepository;
	
	@Autowired
	Cloudinary cloudinary;
	
	@Override
	public LinkDataResponse saveLink(LinkDataRequest request) {
		LinkDataEntity linkDataEntity = new LinkDataEntity();
		linkDataEntity.setDataUrl(request.getDataUrl());
		linkDataEntity.setType(request.getType());
		linkDataEntity.setPublicId(request.getPublicId());
		linkDataRepository.save(linkDataEntity);
		return convertToLinkDataReponse(linkDataEntity);
	}
	
	public LinkDataResponse convertToLinkDataReponse(LinkDataEntity linkDataEntity) {
		LinkDataResponse response = new LinkDataResponse();
		response.setId(linkDataEntity.getId());
		response.setUrl(linkDataEntity.getDataUrl());
		response.setType(linkDataEntity.getType());
		return response;
	}

	@Override
	public LinkDataEntity modifyLink(LinkDataResponse request, Long idService) {
		LinkDataEntity entity = linkDataRepository.findOneById(request.getId());
		entity.setServiceStorage(serviceRepository.findOneById(idService));
		entity.setDataUrl(request.getUrl());
		entity.setType(request.getType());
		linkDataRepository.save(entity);
		return entity;
	}

	@Override
	public String getFirstImage(Long idService) {
		List<LinkDataEntity> links = linkDataRepository.findAllByServiceStorageId(idService);
		String url = "";
		for (LinkDataEntity link : links) {
			if (link.getType().equals("image")) {
				url = link.getDataUrl();
				break;
			}
		}
		return url;
	}
}
