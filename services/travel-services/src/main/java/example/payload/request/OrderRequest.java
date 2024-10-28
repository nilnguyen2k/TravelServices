package example.payload.request;

import java.util.List;

import example.payload.response.CartResponse;

public class OrderRequest {
	
	private InforRequest infor;
	
	// True: mua truc tiep, False: Mua thong qua gio hang
	private boolean statusOrder;
	
	private List<CartRequest> items;
	
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

	public boolean isStatusOrder() {
		return statusOrder;
	}

	public void setStatusOrder(boolean statusOrder) {
		this.statusOrder = statusOrder;
	}
}
