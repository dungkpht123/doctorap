package fpt.fa.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomLoginFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null && authentication.isAuthenticated()) {
            Object principal = authentication.getPrincipal();
            String loggedInUsername = "";

            if (principal instanceof UserDetails) {
                loggedInUsername = ((UserDetails) principal).getUsername();
            } else {
                loggedInUsername = principal.toString();
            }

            // Save the username or other user details into the session or another storage mechanism
            request.getSession().setAttribute("loggedInUser", loggedInUsername);
        }

        filterChain.doFilter(request, response);
    }
}
