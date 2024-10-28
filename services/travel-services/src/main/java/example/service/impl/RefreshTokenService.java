package example.service.impl;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import example.entity.RefreshTokenEntity;
import example.exception.TokenRefreshException;
import example.repository.RefreshTokenRepository;
import example.repository.UserRepository;
import example.service.IRefreshTokenService;

@Service
public class RefreshTokenService implements IRefreshTokenService {
	
	private long refreshTokenDurationMs = 864000000;

	@Autowired
	private RefreshTokenRepository refreshTokenRepository;

	@Autowired
	private UserRepository userRepository;
	
	@Override
	public Optional<RefreshTokenEntity> findByToken(String token) {
		return refreshTokenRepository.findByToken(token);
	}
	
	@Override
	public RefreshTokenEntity createRefreshToken(Long userId) {
		RefreshTokenEntity refreshToken = new RefreshTokenEntity();
		refreshToken.setUser(userRepository.findById(userId).get());
		refreshToken.setExpiryDate(Instant.now().plusMillis(refreshTokenDurationMs));
		refreshToken.setToken(UUID.randomUUID().toString());
		refreshToken = refreshTokenRepository.save(refreshToken);
		return refreshToken;
	}
	
	@Override
	public RefreshTokenEntity verifyExpiration(RefreshTokenEntity token) {
		if (token.getExpiryDate().compareTo(Instant.now()) < 0) {
			refreshTokenRepository.delete(token);
			throw new TokenRefreshException(token.getToken(),
					"Refresh token was expired. Please make a new signin request");
		}
		return token;
	}

	@Transactional
	public int deleteByUserId(Long userId) {
		return refreshTokenRepository.deleteByUser(userRepository.findById(userId).get());
	}

}
