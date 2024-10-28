package example.payload.response;

import java.util.Date;
import java.util.List;

import example.payload.request.InforRequest;

public class GetOrderItemResponse {
	private Long id;
	private Long idOrder;
	private Long idService;
	private String nameService;
	private String description;
	private String url;
	private String bookDay;
	private String bookTime;
	private int total;
	private List<TicketResponse> tickets;
	private InforRequest infor;
	private Date createDate;
	private Date modifiedDate;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getIdOrder() {
		return idOrder;
	}
	public void setIdOrder(Long idOrder) {
		this.idOrder = idOrder;
	}
	public Long getIdService() {
		return idService;
	}
	public void setIdService(Long idService) {
		this.idService = idService;
	}
	public String getNameService() {
		return nameService;
	}
	public void setNameService(String nameService) {
		this.nameService = nameService;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public List<TicketResponse> getTickets() {
		return tickets;
	}
	public void setTickets(List<TicketResponse> tickets) {
		this.tickets = tickets;
	}
	public InforRequest getInfor() {
		return infor;
	}
	public void setInfor(InforRequest infor) {
		this.infor = infor;
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
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
}
