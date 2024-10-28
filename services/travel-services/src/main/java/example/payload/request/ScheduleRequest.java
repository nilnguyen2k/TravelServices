package example.payload.request;

public class ScheduleRequest {
	
	private String time;
	
	private int quantityPerDay;

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
