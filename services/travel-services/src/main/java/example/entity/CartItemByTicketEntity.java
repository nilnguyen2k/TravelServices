package example.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "cartitembyticket")
public class CartItemByTicketEntity {
	
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
	
	@ManyToOne
	@JoinColumn(name = "cartitem_id", foreignKey = @ForeignKey(name = "cartitem_id_fks_service"))
    private CartItemEntity cartItemBy;
	
	@ManyToOne
	@JoinColumn(name = "ticket_id", foreignKey = @ForeignKey(name = "cart_ticket_id_fk_service"))
    private TicketEntity cartTicketBy;
	
	@Column
	private int amount;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public CartItemEntity getCartItemBy() {
		return cartItemBy;
	}

	public void setCartItemBy(CartItemEntity cartItemBy) {
		this.cartItemBy = cartItemBy;
	}

	public TicketEntity getCartTicketBy() {
		return cartTicketBy;
	}

	public void setCartTicketBy(TicketEntity cartTicketBy) {
		this.cartTicketBy = cartTicketBy;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}
}
