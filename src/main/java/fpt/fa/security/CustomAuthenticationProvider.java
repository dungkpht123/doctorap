package fpt.fa.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import fpt.fa.entity.AccountEntity;
import fpt.fa.entity.AllCodes;
import fpt.fa.enums.StatusAccount;
import fpt.fa.service.AccountService;

import java.util.ArrayList;
import java.util.List;

@Component
public class CustomAuthenticationProvider implements
        AuthenticationProvider {
	
	

    @Autowired
    private AccountService accountService;

    @Override
    public Authentication authenticate(Authentication a) throws AuthenticationException {
        String email = a.getName().trim();
        String password = a.getCredentials().toString().trim();
        if (!StringUtils.isEmpty(email) //Sử dụng StringUtils.isEmpty để kiểm tra xem email và mật khẩu có bị rỗng hay không.
                && !StringUtils.isEmpty(password)) {
            AccountEntity account = accountService.findByEmail(email);
            if(BCrypt.checkpw(password, account.getPassword())) //BCrypt.checkpw để xác thực mật khẩu người dùng so với mật khẩu mã hóa trong cơ sở dữ liệu.
            {
                if (account != null && account.getId() > 0 && account.getStatus().equals(StatusAccount.ACTIVE)) {
                    List<GrantedAuthority> roles = new ArrayList<>(); //Tạo danh sách quyền (GrantedAuthority) từ các vai trò của tài khoản.
                    for (AllCodes accountRole : account.getAccountRoles()) {
                        roles.add(
                                new SimpleGrantedAuthority(accountRole.getRole().toString().trim())
                        );
                    }
            //Trả Về Authentication: Nếu tất cả các điều kiện đều đúng, trả về đối tượng UsernamePasswordAuthenticationToken với thông tin người dùng và quyền hạn. Nếu không, trả về null.
                    return new UsernamePasswordAuthenticationToken(account, account.getEmail(), roles);
                } else {
                    return null;
                }
            }else {
            	return null;
            }
            
            
        
        } else {
            return null;
          
        }
    }

    @Override
    public boolean supports(Class<?> type) {
        return type.equals(UsernamePasswordAuthenticationToken.class);
    }

}
