package fpt.fa.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import fpt.fa.entity.AccountEntity;
import fpt.fa.service.AccountService;

@Controller
public class RegisterController {

    @Autowired
    private AccountService accountService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("accountEntity", new AccountEntity());
        return "Doctor/Register"; // This should match the path under WEB-INF/views
    }


    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("accountEntity") AccountEntity account, 
                               BindingResult bindingResult, 
                               Model model,
                               @RequestParam("confirmPassword") String confirmPassword) {

        // Check for validation errors
        if (bindingResult.hasErrors()) {
            return "Doctor/Register";
        }

        // Check if passwords match
        if (!account.getPassword().equals(confirmPassword)) {
            model.addAttribute("message", "Mật khẩu không khớp vui lòng nhập lại!.");
            return "Doctor/Register";
        }

        // Check if email is already used
        if (accountService.findByEmail(account.getEmail()) != null) {
            model.addAttribute("message", "Email này đã được sử dụng vui lòng nhập email mới.");
            return "Doctor/Register";
        }

        // Check if phone number is already used
        if (accountService.findByPhoneNumber(account.getPhoneNumber()) != null) {
            model.addAttribute("message", "Email này đã được sử dụng vui lòng nhập email mới..");
            return "Doctor/Register";
        }

        // Register the new user
        accountService.registerNewUser(account);
        model.addAttribute("message", "Email xác minh đã được gửi tới " + account.getEmail());
        return "Doctor/Register";
    }

    @GetMapping("/verify")
    public String verifyEmail(@RequestParam("token") String token, Model model) {
        if (accountService.verifyEmail(token)) {
            model.addAttribute("message", "Email của bạn đã được xác minh. Bây giờ bạn có thể đăng nhập.");
        } else {
            model.addAttribute("message", "Liên kết xác minh không hợp lệ.");
        }
        return "Doctor/Login";
    }
    
}
