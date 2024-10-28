package example.elasticsearch.model;

import java.util.Date;
import java.util.List;

import example.elasticsearch.ESMArea;
import example.elasticsearch.ESMCategory;
import example.elasticsearch.ESMTicket;

public class ServiceModel {
	
	private Long id;
	
	private String name;
	
	private String address;
	
	private String description;
	
	private String image;
	
	private ESMCategory category;
	
	private ESMArea area;
	
	private List<ESMTicket> ticket;
	
	private int reviews;
	
	private int orders;
	
	private float point;
	
	private Date createDate;

	private Date modifiedDate;

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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public List<ESMTicket> getTicket() {
		return ticket;
	}

	public void setTicket(List<ESMTicket> ticket) {
		this.ticket = ticket;
	}

	public int getReviews() {
		return reviews;
	}

	public void setReviews(int reviews) {
		this.reviews = reviews;
	}

	public int getOrders() {
		return orders;
	}

	public void setOrders(int orders) {
		this.orders = orders;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getModifiedDate() {
		return modifiedDate;
	}

	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}

	public ESMCategory getCategory() {
		return category;
	}

	public void setCategory(ESMCategory category) {
		this.category = category;
	}

	public ESMArea getArea() {
		return area;
	}

	public void setArea(ESMArea area) {
		this.area = area;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public float getPoint() {
		return point;
	}

	public void setPoint(float point) {
		this.point = point;
	}
	
}
