package example.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import example.elasticsearch.ESMArea;
import example.entity.AreaEntity;
import example.entity.OrderItemEntity;
import example.entity.ServiceEntity;
import example.payload.response.AreaResponse;
import example.payload.response.FavoriteAreaResponse;
import example.repository.AreaRepository;
import example.repository.OrderItemRepository;
import example.repository.ServiceRepository;
import example.service.IAreaService;


@Service
public class AreaService implements IAreaService {
	
	@Autowired
	AreaRepository areaRepository;
	
	@Autowired
	ServiceRepository serviceRepo;
	
	@Autowired
	OrderItemRepository orderItemRepo;

	@Override
	public List<AreaResponse> getAllArea() {
		List<AreaResponse> list = new ArrayList<>();
		
		List<AreaEntity> areas = areaRepository.findAll();
		
		for (AreaEntity entity : areas) {
			list.add(convertToAreaResponse(entity));
		}
		
		return list;
	}
	
	@Override
	public AreaResponse convertToAreaResponse(AreaEntity entity) {
		AreaResponse response = new AreaResponse();
		response.setId(entity.getId());
		response.setName(entity.getName());
		response.setUrl(entity.getDataUrl());
		return response;
	}

	@Override
	public ESMArea convertToESMArea(AreaEntity entity) {
		ESMArea area = new ESMArea(entity.getId(), entity.getName());
		return area;
	}

	@Override
	public List<FavoriteAreaResponse> getFavoriteAreaResponse() {
		List<FavoriteAreaResponse> response = new ArrayList<>();
		
		List<OrderItemEntity> allItems = orderItemRepo.findAll();
		List<AreaEntity> areas = areaRepository.findAll();

		// Đầu là id của khu vực, Hai là số lượt đăng ký
		Map<Long, Integer> map = new HashMap<Long, Integer>();
		
		for (int i = 0; i < areas.size(); i++) {
			map.put(areas.get(i).getId(), 0);
		}
		
		for (int i = 0; i < allItems.size(); i++) {
			ServiceEntity service = serviceRepo.findOneById(allItems.get(i).getServiceOrderItem().getId());
			map.replace(service.getAreaService().getId(), map.get(service.getAreaService().getId()) + 1);
		}
		
		LinkedHashMap<Long, Integer> reverseSortedMap = new LinkedHashMap<>();
		 
		map.entrySet()
		  .stream()
		  .sorted(Map.Entry.comparingByValue(Comparator.reverseOrder())) 
		  .forEachOrdered(x -> reverseSortedMap.put(x.getKey(), x.getValue()));
		
		int size = reverseSortedMap.size();
		
		Set<Long> keySet = reverseSortedMap.keySet();
		 
        Long[] keyArray = keySet.toArray(new Long[keySet.size()]);
		
		if (size < 5) {
			for (int i = 0; i < size; i++) {
				AreaEntity area = areaRepository.findOneById(keyArray[i]);
				FavoriteAreaResponse temp = new FavoriteAreaResponse();
				temp.setIdArea(area.getId());
				temp.setNameArea(area.getName());
				temp.setUrl(area.getDataUrl());
				response.add(temp);
			}
		} else {
			for (int i = 0; i < 5; i++) {
				AreaEntity area = areaRepository.findOneById(keyArray[i]);
				FavoriteAreaResponse temp = new FavoriteAreaResponse();
				temp.setIdArea(area.getId());
				temp.setNameArea(area.getName());
				temp.setUrl(area.getDataUrl());
				response.add(temp);
			}
		}
		
		return response;
	}

}
