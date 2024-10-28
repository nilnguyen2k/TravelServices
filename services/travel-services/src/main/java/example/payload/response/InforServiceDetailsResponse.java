package example.payload.response;

import example.entity.AreaEntity;
import example.entity.CategoryEntity;

public class InforServiceDetailsResponse {
	private Long id;
	private String name;
	private String address;
	private String description;
	private String event;
	private String note;
	private CategoryResponse category;
	private AreaResponse area;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public CategoryResponse getCategory() {
		return category;
	}
	public void setCategory(CategoryResponse category) {
		this.category = category;
	}
	public AreaResponse getArea() {
		return area;
	}
	public void setArea(AreaResponse area) {
		this.area = area;
	}
}
