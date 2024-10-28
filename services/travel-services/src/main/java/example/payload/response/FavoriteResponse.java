package example.payload.response;

public class FavoriteResponse {
	
	private Long idService;
	
	private String name;
	
	private String image;
	
	private int reviews;
	
	private float pointReviews;
	
	private int orders;
	
	private int minPrice;

	

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
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

	public int getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(int minPrice) {
		this.minPrice = minPrice;
	}

	public Long getIdService() {
		return idService;
	}

	public void setIdService(Long idService) {
		this.idService = idService;
	}

	public float getPointReviews() {
		return pointReviews;
	}

	public void setPointReviews(float pointReviews) {
		this.pointReviews = pointReviews;
	}
}
