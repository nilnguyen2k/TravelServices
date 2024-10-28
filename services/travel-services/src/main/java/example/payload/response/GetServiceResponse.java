package example.payload.response;

import java.util.List;

import example.elasticsearch.model.ServiceModel;

public class GetServiceResponse {
	private int page;
	
	private int totalPage;
	
	List<ServiceModel> items;

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

	public List<ServiceModel> getItems() {
		return items;
	}

	public void setItems(List<ServiceModel> items) {
		this.items = items;
	}
}
