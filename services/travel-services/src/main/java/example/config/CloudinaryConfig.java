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
			"cloud_name", "",
			"api_key", "",
			"api_secret", "",
			"secure", true
		));
		return c;
	}
}
