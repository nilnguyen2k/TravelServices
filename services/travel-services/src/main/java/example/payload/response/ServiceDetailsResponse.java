package example.payload.response;

import java.util.List;

public class ServiceDetailsResponse {
	private Long createByAuthId;
	private String usernameAuth;
	private Long id;
	private String name;
	private String address;
	private String area;
	private String category;
	private String description;
	private String event;
	private String note;
	private int minPrice;
	private List<ReviewsResponse> reviews;
	private List<LinkDataResponse> galleries; 
	
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
	public int getMinPrice() {
		return minPrice;
	}
	public void setMinPrice(int minPrice) {
		this.minPrice = minPrice;
	}
	public List<ReviewsResponse> getReviews() {
		return reviews;
	}
	public void setReviews(List<ReviewsResponse> reviews) {
		this.reviews = reviews;
	}
	public List<LinkDataResponse> getGalleries() {
		return galleries;
	}
	public void setGalleries(List<LinkDataResponse> galleries) {
		this.galleries = galleries;
	}
	public Long getCreateByAuthId() {
		return createByAuthId;
	}
	public void setCreateByAuthId(Long createByAuthId) {
		this.createByAuthId = createByAuthId;
	}
	public String getUsernameAuth() {
		return usernameAuth;
	}
	public void setUsernameAuth(String usernameAuth) {
		this.usernameAuth = usernameAuth;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}	
}
