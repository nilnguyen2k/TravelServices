package example.payload.request;

public class CreateScheduleRequest {
	
	private String time;
	
	private int quantityPerDay;
		
	private Long idService;

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

	public Long getIdService() {
		return idService;
	}

	public void setIdService(Long idService) {
		this.idService = idService;
	}
	
}

