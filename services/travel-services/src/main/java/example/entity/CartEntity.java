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
@Table(name = "cart")
public class CartEntity {
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
	
	@Column
	private Date createDate;
	
	@Column
	private Date modifiedDate;
	
	@ManyToOne
	@JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "user_id_fk_cart"))
    private UserEntity userCart;
	
	@OneToMany(mappedBy = "cartCartItem")
	private List<CartItemEntity> listCartItem = new ArrayList<>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public UserEntity getUserCart() {
		return userCart;
	}

	public void setUserCart(UserEntity userCart) {
		this.userCart = userCart;
	}

	public List<CartItemEntity> getListCartItem() {
		return listCartItem;
	}

	public void setListCartItem(List<CartItemEntity> listCartItem) {
		this.listCartItem = listCartItem;
	}
}
