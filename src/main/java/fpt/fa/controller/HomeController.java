package fpt.fa.controller;

import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import fpt.fa.entity.AccountEntity;
import fpt.fa.entity.Doctor;
import fpt.fa.entity.Post;
import fpt.fa.service.AccountService;
import fpt.fa.service.DoctorService;
import fpt.fa.service.FileUploadService;
import fpt.fa.service.PostService;
import fpt.fa.service.SpecialtyServices;

@Controller
public class HomeController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private SpecialtyServices specialtyServices;

    @Autowired
    private FileUploadService fileUploadService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Autowired
    private PostService postService;

    @Autowired
    private DoctorService doctorService;

    // Home Page
    @RequestMapping(value = { "/home", "/" }, method = RequestMethod.GET)
    public String defaultAfterLogin(HttpSession session, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Post post = postService.findByUrl("ve-chung-toi");

        if (auth != null && auth.isAuthenticated() && !(auth.getPrincipal() instanceof String)) {
            AccountEntity account = (AccountEntity) auth.getPrincipal();
            session.setAttribute("userId", account.getId());
            session.setAttribute("username", account.getUserName());
            session.setAttribute("account", account);
        } else {
            session.setAttribute("username", "Guest");
        }

        List<Doctor> doctors = doctorService.getAllDoctors();
        doctors.sort(Comparator.comparing(Doctor::getId).reversed());
        if (doctors.size() > 4) {
            doctors = doctors.subList(0, 4);
        }

        model.addAttribute("doctors", doctors);
        model.addAttribute("post", post);
        model.addAttribute("carousel", specialtyServices.showSpecialtyLimit(3));
        model.addAttribute("specialtyList", specialtyServices.showSpecialtyLimit(5));

        return "Doctor/Page/index";
    }

    @RequestMapping(value = { "/login" }, method = RequestMethod.GET)
    public String viewLogin(Model model,
    		 				
                            @RequestParam(value = "error", required = false) String error,
                            @RequestParam(value = "logout", required = false) String logout) {
        if ("email".equals(error)) {
            model.addAttribute("message", "Email không tồn tại trong hệ thống.");
        } else if ("badcredentials".equals(error)) {
            model.addAttribute("message", "Mật khẩu không đúng. Vui lòng thử lại.");
        } else if (error != null) {
            model.addAttribute("message", "Đăng nhập không thành công. Email hoặc mật khẩu không hợp lệ.");
        }

        if (logout != null) {
            model.addAttribute("message", "Bạn đã đăng xuất thành công.");
        }

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !(auth.getPrincipal() instanceof String && ((String) auth.getPrincipal()).equals("anonymousUser"))) {
            return "redirect:/home";
        }

        return "Doctor/Login";
    }


    // Handle Login Success
    @RequestMapping(value = "/login-success", method = RequestMethod.POST)
    public String handleLoginSuccess(HttpSession session, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !(auth.getPrincipal() instanceof String)) {
            AccountEntity account = (AccountEntity) auth.getPrincipal();
            session.setAttribute("username", account.getUserName());
            session.setAttribute("account", account);
            model.addAttribute("message", "Đăng nhập thành công!");
        } else {
            model.addAttribute("error", "Đăng nhập không thành công. Email hoặc mật khẩu không hợp lệ.");
        }
        return "Doctor/Login";
    }
    
    
    // Profile Page
    @RequestMapping(value = { "/profile" }, method = RequestMethod.GET)
    public String showProfile(Model model, HttpSession session) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !(auth.getPrincipal() instanceof String)) {
            AccountEntity account = (AccountEntity) auth.getPrincipal();
            model.addAttribute("account", account);
            session.setAttribute("fullName", account.getUserName());
            session.setAttribute("email", account.getEmail());
        } else {
            model.addAttribute("fullName", "Guest");
            model.addAttribute("email", "N/A");
        }

        return "Doctor/Page/Profile/user-info";
    }

    // Update User Information
    @RequestMapping(value = { "/profile/update" }, method = RequestMethod.POST)
    public String updateUserInfo(@ModelAttribute AccountEntity updatedAccount,
                                  @RequestParam(value = "file", required = false) MultipartFile file,
                                  Model model) {
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            AccountEntity currentUser = (AccountEntity) auth.getPrincipal();

            if (file != null && !file.isEmpty()) {
                String avatar = fileUploadService.uploadFile(file);
                if (avatar != null) {
                    updatedAccount.setAvatar(avatar);
                }
            } else {
                updatedAccount.setAvatar(currentUser.getAvatar());
            }

            updatedAccount.setId(currentUser.getId());
            accountService.updateAccountInfo(updatedAccount, updatedAccount.getAvatar());

            Authentication newAuth = new UsernamePasswordAuthenticationToken(
                    updatedAccount,
                    updatedAccount.getPassword(),
                    SecurityContextHolder.getContext().getAuthentication().getAuthorities()
            );
            SecurityContextHolder.getContext().setAuthentication(newAuth);

            model.addAttribute("message", "User information updated successfully!");
        } catch (Exception e) {
            model.addAttribute("error", "Error updating user information: " + e.getMessage());
            e.printStackTrace();
        }

        return "redirect:/profile";
    }

    // Change Password
    @RequestMapping(value = { "/change-password" }, method = RequestMethod.POST)
    public String changePassword(@RequestParam("currentPassword") String currentPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmNewPassword") String confirmNewPassword,
                                 @RequestParam(value = "file", required = false) MultipartFile file,
                                 Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        AccountEntity currentUser = (AccountEntity) auth.getPrincipal();

        if (!passwordEncoder.matches(currentPassword, currentUser.getPassword())) {
            model.addAttribute("error", "Mật khẩu hiện tại không đúng.");
            model.addAttribute("activeTab", "profile-change-password");
            return "Doctor/Page/Profile/user-info";
        }

        if (!newPassword.equals(confirmNewPassword)) {
            model.addAttribute("error", "Mật khẩu mới không khớp.");
            model.addAttribute("activeTab", "profile-change-password");
            return "Doctor/Page/Profile/user-info";
        }

        currentUser.setPassword(passwordEncoder.encode(newPassword)); // Ensure new password is encoded
        try {
            accountService.updatePassword(currentUser);
        } catch (Exception e) {
            model.addAttribute("error", "Error updating password: " + e.getMessage());
            model.addAttribute("message", "Lỗi khi cập nhật thông tin người dùng.");
            e.printStackTrace();
        }

        Authentication newAuth = new UsernamePasswordAuthenticationToken(
                currentUser,
                currentUser.getPassword(),
                SecurityContextHolder.getContext().getAuthentication().getAuthorities()
        );
        SecurityContextHolder.getContext().setAuthentication(newAuth);

        model.addAttribute("message", "Đổi mật khẩu thành công!");
        model.addAttribute("activeTab", "profile-change-password");

        return "Doctor/Page/Profile/user-info";
    }

   

    // Forgot Password
    @RequestMapping(value = "/forgot-password", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> sendResetCode(@RequestParam("email") String email) {
        Map<String, Object> response = new HashMap<>();
        try {
            boolean emailSent = accountService.sendResetCode(email);
            response.put("success", emailSent);
            response.put("message", emailSent ? "Mã đặt lại đã được gửi đến email của bạn" : "Không tìm thấy địa chỉ email. Vui lòng kiểm tra và thử lại.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "An error occurred: " + e.getMessage());
        }
        return response;
    }

    // Reset Password
    @RequestMapping(value = "/reset-password", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> resetPassword(@RequestParam("email") String email,
                                                            @RequestParam("resetCode") String resetCode,
                                                            @RequestParam("newPassword") String newPassword,
                                                            @RequestParam("confirmPassword") String confirmPassword) {
        Map<String, Object> response = new HashMap<>();
        try {
            if (!newPassword.equals(confirmPassword)) {
                response.put("success", false);
                response.put("message", "Mật khẩu không khớp.");
                return response;
            }

            boolean success = accountService.resetPassword(email, resetCode, passwordEncoder.encode(newPassword));

            response.put("success", success);
            response.put("message", success ? "Mật khẩu đã được đặt lại thành công." : "Mã đặt lại hoặc email không hợp lệ.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "An error occurred: " + e.getMessage());
        }
        return response;
    }

    // Verify Reset Code
    @RequestMapping(value = "/verify-reset-code", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> verifyResetCode(@RequestParam("email") String email,
                                                             @RequestParam("resetCode") String resetCode) {
        Map<String, Object> response = new HashMap<>();
        try {
            boolean isValidCode = accountService.verifyResetCode(email, resetCode);
            response.put("success", isValidCode);
            response.put("message", isValidCode ? "Reset code verified successfully." : "Invalid or expired reset code.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "An error occurred: " + e.getMessage());
        }
        return response;
    }

    // Doctors List with Pagination
    @GetMapping("/Bac-si")
    public String ourDoctor(Model model,
                            @RequestParam(value = "page", defaultValue = "1") int page,
                            @RequestParam(value = "size", defaultValue = "8") int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        Page<Doctor> pageList = doctorService.getListDoctorWithPaging(pageable);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageList.getTotalPages());
        model.addAttribute("pageList", pageList);
        model.addAttribute("doctors", pageList.getContent());

        return "Doctor/Page/team";
    }

    public static class ResponseMessage {
        private String message;

        public ResponseMessage(String message) {
            this.message = message;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }
}
