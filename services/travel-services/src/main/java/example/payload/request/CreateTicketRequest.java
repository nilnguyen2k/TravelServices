package example.payload.request;

public class CreateTicketRequest {
	
	private int valueTicket;
	
	private String typeTicket;
	
	private String noteTicket;
	
	private int amountTicket;
	
	private Long idService;

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

	public String getNoteTicket() {
		return noteTicket;
	}

	public void setNoteTicket(String noteTicket) {
		this.noteTicket = noteTicket;
	}

	public int getAmountTicket() {
		return amountTicket;
	}

	public void setAmountTicket(int amountTicket) {
		this.amountTicket = amountTicket;
	}

	public Long getIdService() {
		return idService;
	}

	public void setIdService(Long idService) {
		this.idService = idService;
	}
}
