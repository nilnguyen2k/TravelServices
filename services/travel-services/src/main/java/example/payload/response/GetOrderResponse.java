package example.payload.response;

import java.util.List;

public class GetOrderResponse {
	
	private int page;
	
	private int totalPage;
	
	private List<OrderObjectResponse> data;
	
	public int getPage() {
		return page;
	}
	
	public void setPage(int page) {
		this.page = page;
	}
	
	public int getTotalPage() {
		return totalPage;
	}
	
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	
	public List<OrderObjectResponse> getData() {
		return data;
	}
	
	public void setData(List<OrderObjectResponse> data) {
		this.data = data;
	}
	
}
