package example.payload.response;

public class CalenderOrderResponse {
	
	private String service;
	
	private String bookDay;
	
	private String bookTime;
	
	private String status;
	
	public String getService() {
		return service;
	}
	
	public void setService(String service) {
		this.service = service;
	}
	
	public String getBookDay() {
		return bookDay;
	}
	
	public void setBookDay(String bookDay) {
		this.bookDay = bookDay;
	}
	
	public String getBookTime() {
		return bookTime;
	}
	
	public void setBookTime(String bookTime) {
		this.bookTime = bookTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
