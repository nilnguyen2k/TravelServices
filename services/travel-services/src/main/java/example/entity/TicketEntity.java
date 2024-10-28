package example.entity;

import java.util.ArrayList;
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
@Table(name = "ticket")
public class TicketEntity {
	
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
	
	@Column
	private int value;
	
	@Column
	private String type;
	
	@Column
	private String note;
	
	@Column
	private int amount;
	
	@ManyToOne
	@JoinColumn(name = "service_id", foreignKey = @ForeignKey(name = "service_id_fk_ticket"))
    private ServiceEntity serviceTicket;
	
	@OneToMany(mappedBy = "ticketBy")
	private List<OrderItemByTicketEntity> listOrderByTicket = new ArrayList<>();
	
	@OneToMany(mappedBy = "cartTicketBy")
	private List<CartItemByTicketEntity> listCartByTicket = new ArrayList<>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public ServiceEntity getServiceTicket() {
		return serviceTicket;
	}

	public void setServiceTicket(ServiceEntity serviceTicket) {
		this.serviceTicket = serviceTicket;
	}

	public List<OrderItemByTicketEntity> getListOrderByTicket() {
		return listOrderByTicket;
	}

	public void setListOrderByTicket(List<OrderItemByTicketEntity> listOrderByTicket) {
		this.listOrderByTicket = listOrderByTicket;
	}

	public List<CartItemByTicketEntity> getListCartByTicket() {
		return listCartByTicket;
	}

	public void setListCartByTicket(List<CartItemByTicketEntity> listCartByTicket) {
		this.listCartByTicket = listCartByTicket;
	}
}
