package example.payload.response;

public class TicketResponse {
	
	private Long idTicket;
	
	private int valueTicket;
	
	private String typeTicket;
	
	private int amountTicket;
	
	private String note;

	public Long getIdTicket() {
		return idTicket;
	}

	public void setIdTicket(Long idTicket) {
		this.idTicket = idTicket;
	}

	public int getValueTicket() {
		return valueTicket;
	}

	public void setValueTicket(int valueTicket) {
		this.valueTicket = valueTicket;
	}

	public String getTypeTicket() {
		return typeTicket;
	}

	public void setTypeTicket(String typeTicket) {
		this.typeTicket = typeTicket;
	}

	public int getAmountTicket() {
		return amountTicket;
	}

	public void setAmountTicket(int amountTicket) {
		this.amountTicket = amountTicket;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
}
