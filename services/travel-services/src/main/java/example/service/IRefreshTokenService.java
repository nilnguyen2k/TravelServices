package example.service;

import java.util.Optional;

import example.entity.RefreshTokenEntity;

public interface IRefreshTokenService {
	Optional<RefreshTokenEntity> findByToken(String token);
	RefreshTokenEntity createRefreshToken(Long id);
	RefreshTokenEntity verifyExpiration(RefreshTokenEntity token);
}
