package example.payload.response;

import java.util.List;

public class GetCartResponse {
	
	private int page;
	
	private int totalPage;
	
	private List<CartResponse> data;

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

	public List<CartResponse> getData() {
		return data;
	}

	public void setData(List<CartResponse> data) {
		this.data = data;
	}
}
