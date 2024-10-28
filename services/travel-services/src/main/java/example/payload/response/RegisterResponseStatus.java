package example.payload.response;

public class RegisterResponseStatus {
	private Object data;
	private String status;

	public RegisterResponseStatus(Object data, String status) {
		this.data = data;
		this.status = status;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
