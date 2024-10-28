package example.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import example.payload.response.FavoriteResponse;
import example.payload.response.MessageResponse;
import example.service.impl.FavoriteService;


@CrossOrigin
@RestController
public class FavoriteAPI {
	
	@Autowired
	FavoriteService favoriteService;
	
	@GetMapping(value = "/favorite")
	List<FavoriteResponse> getAllFavorite() {
		return favoriteService.getAllFavoriteByUser();
	}
	
	@PostMapping(value = "/favorite")
	List<FavoriteResponse> insertFavorite(@RequestParam("idService") Long idService) {
		return favoriteService.insertFavorite(idService);
	}
	
	@DeleteMapping(value = "/favorite")
	List<FavoriteResponse> deleteFavorite(@RequestParam("idService") String idService) {
		return favoriteService.deleteFavorite(Long.parseLong(idService));
	}
	
	

}
