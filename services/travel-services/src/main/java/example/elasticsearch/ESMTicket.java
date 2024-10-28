package example.elasticsearch;

public class ESMTicket {
	
	private Long id;
	
	private int value;

	private String type;
	
	private int amount;
	

	public ESMTicket(Long id, int value, String type, int amount) {
		this.id = id;
		this.value = value;
		this.type = type;
		this.amount = amount;
	}
	
	

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}



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
	
	
	
}
