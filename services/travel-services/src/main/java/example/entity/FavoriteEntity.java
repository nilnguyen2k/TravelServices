package example.entity;

import javax.persistence.Entity;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "favorite")
public class FavoriteEntity {
	
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
	
	@ManyToOne
	@JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "user_id_fk_favorite"))
    private UserEntity userFavorite;
	
	@ManyToOne
	@JoinColumn(name = "service_id", foreignKey = @ForeignKey(name = "service_id_fk_favorite"))
    private ServiceEntity serviceFavorite;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public UserEntity getUserFavorite() {
		return userFavorite;
	}

	public void setUserFavorite(UserEntity userFavorite) {
		this.userFavorite = userFavorite;
	}

	public ServiceEntity getServiceFavorite() {
		return serviceFavorite;
	}

	public void setServiceFavorite(ServiceEntity serviceFavorite) {
		this.serviceFavorite = serviceFavorite;
	}
}
