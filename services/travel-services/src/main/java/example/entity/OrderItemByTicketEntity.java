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
@Table(name = "orderitembyticket")
public class OrderItemByTicketEntity {
	
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
	
	@ManyToOne
	@JoinColumn(name = "orderitem_id", foreignKey = @ForeignKey(name = "orderitem_id_fks_service"))
    private OrderItemEntity orderItemBy;
	
	@ManyToOne
	@JoinColumn(name = "ticket_id", foreignKey = @ForeignKey(name = "order_ticket_id_fk_service"))
    private TicketEntity ticketBy;
	
	@Column
	private int amount;
	
	@Column
	private int currentPrice;
	
	@Column
	private String type;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public OrderItemEntity getOrderItemBy() {
		return orderItemBy;
	}

	public void setOrderItemBy(OrderItemEntity orderItemBy) {
		this.orderItemBy = orderItemBy;
	}

	public TicketEntity getTicketBy() {
		return ticketBy;
	}

	public void setTicketBy(TicketEntity ticketBy) {
		this.ticketBy = ticketBy;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getCurrentPrice() {
		return currentPrice;
	}

	public void setCurrentPrice(int currentPrice) {
		this.currentPrice = currentPrice;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
