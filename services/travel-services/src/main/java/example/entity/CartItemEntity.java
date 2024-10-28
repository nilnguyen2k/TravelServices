package example.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
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
@Table(name = "cartitem")
public class CartItemEntity {
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
	
	@ManyToOne
	@JoinColumn(name = "service_id", foreignKey = @ForeignKey(name = "service_id_fk_cartitem"))
    private ServiceEntity serviceCartItem;
	
	@ManyToOne
	@JoinColumn(name = "cart_id", foreignKey = @ForeignKey(name = "cart_id_fk_cartitem"))
    private CartEntity cartCartItem;
	
	@OneToMany(mappedBy = "cartItemBy")
	private List<CartItemByTicketEntity> listCartByTicket = new ArrayList<>();
	
	@Column
	private String bookDay;
	
	@Column
	private String bookTime;
	
	@Column
	private Date createDate;
	
	@Column
	private Date modifiedDate;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public ServiceEntity getServiceCartItem() {
		return serviceCartItem;
	}

	public void setServiceCartItem(ServiceEntity serviceCartItem) {
		this.serviceCartItem = serviceCartItem;
	}

	public CartEntity getCartCartItem() {
		return cartCartItem;
	}

	public void setCartCartItem(CartEntity cartCartItem) {
		this.cartCartItem = cartCartItem;
	}

	public List<CartItemByTicketEntity> getListCartByTicket() {
		return listCartByTicket;
	}

	public void setListCartByTicket(List<CartItemByTicketEntity> listCartByTicket) {
		this.listCartByTicket = listCartByTicket;
	}

	public String getBookDay() {
		return bookDay;
	}

	public void setBookDay(String bookDay) {
		this.bookDay = bookDay;
	}

	public String getBookTime() {
		return bookTime;
	}

	public void setBookTime(String bookTime) {
		this.bookTime = bookTime;
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
}
