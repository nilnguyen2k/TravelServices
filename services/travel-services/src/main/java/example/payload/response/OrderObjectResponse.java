package example.payload.response;

import java.util.Date;
import java.util.List;

import example.payload.request.InforRequest;

public class OrderObjectResponse {
	
	private Long idOrder;
	
	private InforRequest infor;
	
	private List<OrderItemResponse> items;
	
	private int totalOrder;
	
	private Date createDate;
	
	public Long getIdOrder() {
		return idOrder;
	}
	
	public void setIdOrder(Long idOrder) {
		this.idOrder = idOrder;
	}
	
	public InforRequest getInfor() {
		return infor;
	}
	
	public void setInfor(InforRequest infor) {
		this.infor = infor;
	}
	
	public List<OrderItemResponse> getItems() {
		return items;
	}
	
	public void setItems(List<OrderItemResponse> items) {
		this.items = items;
	}
	
	public int getTotalOrder() {
		return totalOrder;
	}
	
	public void setTotalOrder(int totalOrder) {
		this.totalOrder = totalOrder;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	} 
}
