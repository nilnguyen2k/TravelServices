package example.elasticsearch;

public class ESMSchedule {
	
	private Long id;
	
	private int quantity_per_day;

	private String time;
	
	

	public ESMSchedule(Long id, int quantity_per_day, String time) {
		this.id = id;
		this.quantity_per_day = quantity_per_day;
		this.time = time;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getQuantity_per_day() {
		return quantity_per_day;
	}

	public void setQuantity_per_day(int quantity_per_day) {
		this.quantity_per_day = quantity_per_day;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
	
}
