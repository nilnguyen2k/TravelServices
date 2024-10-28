package example.service;

import java.util.List;

import example.payload.response.FavoriteResponse;
import example.payload.response.MessageResponse;

public interface IFavoriteService {
	List<FavoriteResponse> getAllFavoriteByUser();
	List<FavoriteResponse> deleteFavorite(Long idService);
	List<FavoriteResponse> insertFavorite(Long idService);
}
