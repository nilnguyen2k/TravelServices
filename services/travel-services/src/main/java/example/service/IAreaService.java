package example.service;

import java.util.List;

import example.elasticsearch.ESMArea;
import example.entity.AreaEntity;
import example.payload.response.AreaResponse;
import example.payload.response.FavoriteAreaResponse;

public interface IAreaService {
	List<AreaResponse> getAllArea();
	AreaResponse convertToAreaResponse(AreaEntity entity);
	ESMArea convertToESMArea(AreaEntity entity);
	
	List<FavoriteAreaResponse> getFavoriteAreaResponse();
}
