package example.payload.request;

public class LinkDataRequest {
	
	private String dataUrl;
	
	private String type;
	
	private String publicId;
	
	public LinkDataRequest(String dataUrl, String type, String publicId) {
		this.dataUrl = dataUrl;
		this.type = type;
		this.publicId = publicId;
	}
	
	
	public String getPublicId() {
		return publicId;
	}

	public void setPublicId(String publicId) {
		this.publicId = publicId;
	}

	public String getDataUrl() {
		return dataUrl;
	}
	public void setDataUrl(String dataUrl) {
		this.dataUrl = dataUrl;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
