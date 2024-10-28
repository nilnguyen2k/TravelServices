package example.payload.response;

public class ScheduleResponse {
	private Long id;
	
	private String time;
	
	private int quantityPerDay;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public int getQuantityPerDay() {
		return quantityPerDay;
	}

	public void setQuantityPerDay(int quantityPerDay) {
		this.quantityPerDay = quantityPerDay;
	}
}
