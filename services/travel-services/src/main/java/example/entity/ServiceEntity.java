package example.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "service")
public class ServiceEntity {
	
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
	
	@Column
	private String name;
	
	@Column
	private String address;
	
	@Column(columnDefinition = "TEXT")
	private String description;
	
	@Column(columnDefinition = "TEXT")
	private String note;
	
	@Column(columnDefinition = "TEXT")
	private String event; 
	
	@Column
	private Date createDate;
	
	@Column
	private Date modifiedDate;
	
	@Column
	private boolean status;
	
	
	@ManyToOne
	@JoinColumn(name = "category_id", foreignKey = @ForeignKey(name = "category_id_fk_service"))
    private CategoryEntity categoryService;
	
	@ManyToOne
	@JoinColumn(name = "area_id", foreignKey = @ForeignKey(name = "area_id_fk_service"))
    private AreaEntity areaService;
	
	@OneToMany(mappedBy = "serviceOrderItem")
	private List<OrderItemEntity> listOrderItem = new ArrayList<>();
	
	@OneToMany(mappedBy = "serviceFavorite")
	private List<FavoriteEntity> listFavorite = new ArrayList<>();
	
	@OneToMany(mappedBy = "serviceSchedule")
	private List<ScheduleEntity> listSchedule = new ArrayList<>();
	
	@ManyToOne
	@JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "user_id_fk_service"))
    private UserEntity userService;
	
	
	@OneToMany(mappedBy = "serviceStorage")
	private List<LinkDataEntity> listStorage = new ArrayList<>();
	
	@OneToMany(mappedBy = "serviceReview")
	private List<ReviewEntity> listReview = new ArrayList<>();
	
	@OneToMany(mappedBy = "serviceTicket")
	private List<TicketEntity> listTicket = new ArrayList<>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getEvent() {
		return event;
	}

	public void setEvent(String event) {
		this.event = event;
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

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public CategoryEntity getCategoryService() {
		return categoryService;
	}

	public void setCategoryService(CategoryEntity categoryService) {
		this.categoryService = categoryService;
	}

	public AreaEntity getAreaService() {
		return areaService;
	}

	public void setAreaService(AreaEntity areaService) {
		this.areaService = areaService;
	}

	public List<OrderItemEntity> getListOrderItem() {
		return listOrderItem;
	}

	public void setListOrderItem(List<OrderItemEntity> listOrderItem) {
		this.listOrderItem = listOrderItem;
	}

	public UserEntity getUserService() {
		return userService;
	}

	public void setUserService(UserEntity userService) {
		this.userService = userService;
	}

	public List<LinkDataEntity> getListStorage() {
		return listStorage;
	}

	public void setListStorage(List<LinkDataEntity> listStorage) {
		this.listStorage = listStorage;
	}

	public List<ReviewEntity> getListReview() {
		return listReview;
	}

	public void setListReview(List<ReviewEntity> listReview) {
		this.listReview = listReview;
	}

	public List<TicketEntity> getListTicket() {
		return listTicket;
	}

	public void setListTicket(List<TicketEntity> listTicket) {
		this.listTicket = listTicket;
	}

	public List<ScheduleEntity> getListSchedule() {
		return listSchedule;
	}

	public void setListSchedule(List<ScheduleEntity> listSchedule) {
		this.listSchedule = listSchedule;
	}

	public List<FavoriteEntity> getListFavorite() {
		return listFavorite;
	}

	public void setListFavorite(List<FavoriteEntity> listFavorite) {
		this.listFavorite = listFavorite;
	}
		
}
