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
@Table(name = "schedule")
public class ScheduleEntity {
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
	
	@ManyToOne
	@JoinColumn(name = "service_id", foreignKey = @ForeignKey(name = "service_id_fk_schedule"))
    private ServiceEntity serviceSchedule;
	
	@Column(name = "quantityPerDay")
	private int quantityperday;
	
	@Column
	private String time;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public ServiceEntity getServiceSchedule() {
		return serviceSchedule;
	}

	public void setServiceSchedule(ServiceEntity serviceSchedule) {
		this.serviceSchedule = serviceSchedule;
	}

	public int getQuantityperday() {
		return quantityperday;
	}

	public void setQuantityperday(int quantityperday) {
		this.quantityperday = quantityperday;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
}
