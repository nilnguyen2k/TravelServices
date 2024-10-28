package example.payload.response;

public class ServiceResponse {
	
	private Long idService;
	
	private String name;
	
	private String description;
	
	private String event;
	
	private String area;
	
	private String category;
	
	public Long getIdService() {
		return idService;
	}
	
	public void setIdService(Long idService) {
		this.idService = idService;
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
	
	public String getEvent() {
		return event;
	}
	
	public void setEvent(String event) {
		this.event = event;
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
