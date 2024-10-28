package example.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import example.elasticsearch.ESMCategory;
import example.entity.CategoryEntity;
import example.payload.response.CategoryResponse;
import example.repository.CategoryRepository;
import example.service.ICategoryService;

@Service
public class CategoryService implements ICategoryService {
	
	@Autowired
	CategoryRepository categoryRepository;

	@Override
	public List<CategoryResponse> getAllCategory() {
		List<CategoryEntity> entities = categoryRepository.findAll();
		List<CategoryResponse> categoryResponse = new ArrayList<>();
		
		for (CategoryEntity entity : entities) {
			categoryResponse.add(convertToCategoryResponse(entity));
		}
		
		return categoryResponse;
	}

	@Override
	public CategoryResponse convertToCategoryResponse(CategoryEntity entity) {
		CategoryResponse category = new CategoryResponse();
		category.setId(entity.getId());
		category.setName(entity.getName());
		category.setIcon(entity.getIcon());
		return category;
	}

	@Override
	public ESMCategory convertToESMCategory(CategoryEntity entity) {
		ESMCategory category = new ESMCategory(entity.getId(), entity.getName());
		return category;
	}

}
