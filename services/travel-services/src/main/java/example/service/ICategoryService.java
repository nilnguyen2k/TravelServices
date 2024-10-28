package example.service;

import java.util.List;

import example.elasticsearch.ESMCategory;
import example.entity.CategoryEntity;
import example.payload.response.CategoryResponse;

public interface ICategoryService {
	List<CategoryResponse> getAllCategory();
	CategoryResponse convertToCategoryResponse(CategoryEntity entity);
	ESMCategory convertToESMCategory(CategoryEntity entity);
}
