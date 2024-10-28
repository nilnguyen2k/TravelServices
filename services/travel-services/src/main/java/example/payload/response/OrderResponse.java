package example.payload.response;

import java.util.List;

import example.payload.request.CartRequest;
import example.payload.request.InforRequest;

public class OrderResponse {
	
	private Long idOrder;
	
	private InforRequest infor;
	
	private List<CartRequest> items;

	public OrderResponse(Long idOrder, InforRequest infor, List<CartRequest> items) {
		this.idOrder = idOrder;
		this.infor = infor;
		this.items = items;
	}

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

	public List<CartRequest> getItems() {
		return items;
	}

	public void setItems(List<CartRequest> items) {
		this.items = items;
	}
}
