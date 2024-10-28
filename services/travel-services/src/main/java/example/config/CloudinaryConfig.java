package example.config;

import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

@Component
public class CloudinaryConfig {
	@Bean
	public Cloudinary cloundinary() {
		Cloudinary c = new Cloudinary(ObjectUtils.asMap(
			"cloud_name", "nilnguyen",
			"api_key", "193592483784513",
			"api_secret", "GhsmWgQIxOwLb0BAAqIy0IMCjIU",
			"secure", true
		));
		return c;
	}
}
