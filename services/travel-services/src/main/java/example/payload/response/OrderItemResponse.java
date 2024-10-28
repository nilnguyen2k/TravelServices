package example.payload.response;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;

public class OrderItemResponse {
	
	private Long idService;
	
	private String bookDay;
	
	private String bookTime;
	
	private String name;
	
	private String description;
	
	private String url;
	
	private Date createDate;
	
	private int totalItem;
	
	private List<TicketResponse> tickets;
	
	public Long getIdService() {
		return idService;
	}
	
	public void setIdService(Long idService) {
		this.idService = idService;
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

	public int getTotalItem() {
		return totalItem;
	}
	
	public void setTotalItem(int totalItem) {
		this.totalItem = totalItem;
	}
	
	public List<TicketResponse> getTickets() {
		return tickets;
	}
	
	public void setTickets(List<TicketResponse> tickets) {
		this.tickets = tickets;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
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

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
}
