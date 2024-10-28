package example.payload.response;

import java.util.List;

public class AdminOrderItemResponse {
	
	private int page;
	
	private int totalPage;

	private List<GetOrderItemResponse> data;

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

	public List<GetOrderItemResponse> getData() {
		return data;
	}

	public void setData(List<GetOrderItemResponse> data) {
		this.data = data;
	}
	
	
}
