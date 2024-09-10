package fpt.fa.config;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;

public class SecurityConfig  {
	  @Autowired
	    private CustomAuthenticationFailureHandler customAuthenticationFailureHandler;

	    protected void configure(HttpSecurity http) throws Exception {
	        http
	            .authorizeRequests()
	                .antMatchers("/home", "/login", "/register").permitAll()
	                .anyRequest().authenticated()
	            .and()
	            .formLogin()
	                .loginPage("/login")
	                .failureHandler(customAuthenticationFailureHandler) // Use the custom failure handler
	                .defaultSuccessUrl("/home")
	                .permitAll()
	            .and()
	            .logout()
	                .permitAll();
	    }
	    
}
