package fpt.fa.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	/*
	 * @Override public void addErrorPages(ErrorPageRegistry registry) {
	 * registry.addErrorPages(new ErrorPage(HttpStatus.NOT_FOUND, "/error/404")); }
	 * 
	 * @Bean public ErrorViewResolver errorViewResolver() { return (request, status,
	 * exception) -> { if (status.value() == HttpStatus.NOT_FOUND.value()) {
	 * Map<String, Object> model = new HashMap<>(); model.put("exception",
	 * exception); return new InternalResourceView("/WEB-INF/views/error/404.jsp");
	 * } return null; }; }
	 */
}
