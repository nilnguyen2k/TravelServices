package example.payload.response;

import java.util.Date;

public class ReviewsResponse {
	private Long id;
	private String content;
	private float point;
	private Date createDate;
	private Date modifiedDate;
	private UserReviewResponse user;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public float getPoint() {
		return point;
	}
	public void setPoint(float point) {
		this.point = point;
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
	public UserReviewResponse getUser() {
		return user;
	}
	public void setUser(UserReviewResponse user) {
		this.user = user;
	}
}
