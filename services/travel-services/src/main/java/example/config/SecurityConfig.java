package example.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import example.config.jwt.JwtAuthenticationFilter;
import example.service.impl.UserService;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

	@Autowired
	UserService userService;
	
	@Bean
	public JwtAuthenticationFilter jwtAuthenticationFilter() {
		return new JwtAuthenticationFilter();
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
		return authenticationConfiguration.getAuthenticationManager();
	}

	@Bean
	public DaoAuthenticationProvider authenticationProvider() {
	    DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
	     
	    authProvider.setUserDetailsService(userService);
	    authProvider.setPasswordEncoder(passwordEncoder());
	 
	    return authProvider;
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

		http.cors().and().csrf().disable();
		
		http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
		
		http.addFilterBefore(jwtAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);
		
		http.authenticationProvider(authenticationProvider());
		
		http.authorizeRequests()
				.antMatchers("/user/orderitem/update").permitAll()
				.antMatchers("/public/favoriteService").permitAll()
				.antMatchers("/public/favoriteArea").permitAll()
				.antMatchers("/auth/register").permitAll()
				.antMatchers("/auth/refreshtoken").permitAll()
				.antMatchers("/auth/changepassword").permitAll()
				.antMatchers("/auth/forgotpassword").permitAll()
				.antMatchers("/admin/serviceDetails").permitAll()
				.antMatchers("/auth/resetpassword").permitAll()
				.antMatchers("/auth/login").permitAll()
				.antMatchers("/order/range").permitAll()
				.antMatchers("/public/service").permitAll()
				.antMatchers("/public/serviceDetails").permitAll()
				.antMatchers("/public/area").permitAll()
				.antMatchers("/public/category").permitAll()
				.antMatchers("/public/about").permitAll()
				.anyRequest().authenticated();

		return http.build();
	}
}

