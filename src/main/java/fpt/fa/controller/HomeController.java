package fpt.fa.controller;

import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.data.domain.Pageable;

import fpt.fa.entity.AccountEntity;
import fpt.fa.entity.Doctor;
import fpt.fa.entity.Post;
import fpt.fa.entity.Specialty;
import fpt.fa.enums.Gender;
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
		    
	@RequestMapping(value = { "/home", "/" }, method = RequestMethod.GET)
	public String defaultAfterLogin(HttpSession session,Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Post post = postService.findByUrl("ve-chung-toi");
		if (auth != null && auth.isAuthenticated() && !(auth.getPrincipal() instanceof String)) {
			AccountEntity account = (AccountEntity) auth.getPrincipal();
			String username = account.getUserName();
			int userId = account.getId();
			session.setAttribute("userId", userId);
			session.setAttribute("username", username); // Lưu vào session
			session.setAttribute("account", account);
		} else {
			session.setAttribute("username", "Guest"); // Hoặc có thể bỏ qua
		}
		List<Doctor> doctors = doctorService.getAllDoctors();
		doctors.sort(Comparator.comparing(Doctor::getId).reversed()); // Sắp xếp theo id giảm dần
		 if (doctors.size() > 4) {
		        doctors = doctors.subList(0, 4);
		    }
	    model.addAttribute("doctors", doctors);
		model.addAttribute("post", post);
		model.addAttribute("carousel", specialtyServices.showSpecialtyLimit(3));
		model.addAttribute("specialtyList",specialtyServices.showSpecialtyLimit(5));
		return "Doctor/Page/index"; // Trang chính của bạn
		
		
		
		
		
	}

	@RequestMapping(value = { "/login" }, method = RequestMethod.GET)
	public String viewLogin(Model model, @RequestParam(value = "error", required = false) String error,
	        @RequestParam(value = "logout", required = false) String logout) {
	    if (error != null) {
	        model.addAttribute("message", "Đăng nhập không thành công! Email hoặc mật khẩu không hợp lệ.");
	    }

	    if (logout != null) {
	        model.addAttribute("message", "Bạn đã đăng xuất thành công");
	    }

	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null && auth.isAuthenticated() && !(auth.getPrincipal() instanceof String && ((String) auth.getPrincipal()).equals("anonymousUser"))) {
	        return "redirect:/home";
	    }

	    return "Doctor/Login";
	}

	@RequestMapping(value = { "/profile" }, method = RequestMethod.GET)
	public String showProfile(Model model, HttpSession session) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && auth.isAuthenticated() && !(auth.getPrincipal() instanceof String)) {
			AccountEntity account = (AccountEntity) auth.getPrincipal();

			// Thêm thông tin vào model
			model.addAttribute("account", account);
			// Lưu thông tin vào session nếu cần
			session.setAttribute("fullName", account.getUserName());
			session.setAttribute("email", account.getEmail());
		} else {
			model.addAttribute("fullName", "Guest");
			model.addAttribute("email", "N/A");
		}

		return "Doctor/Page/Profile/user-info";
	}


	@RequestMapping(value = {"/profile/update"}, method = RequestMethod.POST)
	public String updateUserInfo(@ModelAttribute AccountEntity updatedAccount, 
	                              @RequestParam(value = "file", required = false) MultipartFile file,
	                              Model model) {
	    try {
	        // Nhận thông tin người dùng đã đăng nhập hiện tại
	        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	        AccountEntity currentUser = (AccountEntity) auth.getPrincipal();
 
	        
	        if (file != null && !file.isEmpty()) {
	            String avatar = fileUploadService.uploadFile(file);
	            if (avatar != null) {
	                updatedAccount.setAvatar(avatar); // Cập nhật avatar mới nếu có
	            }
	        } else {
	            updatedAccount.setAvatar(currentUser.getAvatar());
	        }
 
	        
	        updatedAccount.setId(currentUser.getId());
 
	        // Cập nhật thông tin người dùng qua service
	        accountService.updateAccountInfo(updatedAccount, updatedAccount.getAvatar());
 
	        // Làm mới xác thực với thông tin đã cập nhật
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

	
	@RequestMapping(value = {"/change-password"}, method = RequestMethod.POST)
	public String changePassword(@RequestParam("currentPassword") String currentPassword,
	                             @RequestParam("newPassword") String newPassword,
	                             @RequestParam("confirmNewPassword") String confirmNewPassword,
	                             @RequestParam("file") MultipartFile file ,
	                             Model model) {
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    AccountEntity currentUser = (AccountEntity) auth.getPrincipal();

	    // Kiểm tra mật khẩu hiện tại
	    if (!passwordEncoder.matches(currentPassword, currentUser.getPassword())) {
	        model.addAttribute("error", "Mật khẩu hiện tại không đúng.");
	        model.addAttribute("activeTab", "profile-change-password");
	        return "Doctor/Page/Profile/user-info";
	    }

	    // Kiểm tra mật khẩu mới và xác nhận
	    if (!newPassword.equals(confirmNewPassword)) {
	        model.addAttribute("error", "Mật khẩu mới không khớp.");
	        model.addAttribute("activeTab", "profile-change-password");
	        return "Doctor/Page/Profile/user-info";
	    }

	    // Cập nhật mật khẩu mới
	    currentUser.setPassword(newPassword); // Chỉ đặt mật khẩu, mã hóa sẽ được thực hiện trong dịch vụ
	    try {
	    // Cập nhật thông tin người dùng
	    accountService.updatePassword(currentUser);
	    } catch (Exception e) {
            // Xử lý lỗi và thêm thông báo lỗi vào model
            model.addAttribute("error", "File upload failed: " + e.getMessage());
            model.addAttribute("message", "Lỗi khi cập nhật thông tin người dùng.");
            e.printStackTrace(); // Ghi lỗi vào log để theo dõi
        }
	    // Tạo lại Authentication mới
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
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/login-success", method = RequestMethod.POST)
    public String handleLoginSuccess(HttpSession session, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !(auth.getPrincipal() instanceof String)) {
            AccountEntity account = (AccountEntity) auth.getPrincipal();
            session.setAttribute("username", account.getUserName());
            session.setAttribute("account", account);
            model.addAttribute("message", "Đăng nhập thành công!");
        } else {
            model.addAttribute("message", "Đăng nhập không thành công.");
        }
        return "Doctor/Login"; // Chuyển hướng đến trang chính sau khi xử lý
    }
	
	// xử ly lấy lại mật khẩu
	@RequestMapping(value = "/forgot-password", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> sendResetCode(@RequestParam("email") String email) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        boolean emailSent = accountService.sendResetCode(email);

	        if (emailSent) {
	            response.put("success", true);
	            response.put("message", "Mã đặt lại đã được gửi đến email của bạn ");
	        } else {
	            response.put("success", false);
	            response.put("message", "Không tìm thấy địa chỉ email. Vui lòng kiểm tra và thử lại.");
	        }
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "An error occurred: " + e.getMessage());
	    }
	    return response;
	}

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

	        boolean success = accountService.resetPassword(email, resetCode, newPassword);

	        if (success) {
	            response.put("success", true);
	            response.put("message", "Mật khẩu đã được đặt lại thành công.");
	        } else {
	            response.put("success", false);
	            response.put("message", "Mã đặt lại hoặc email không hợp lệ.");
	        }
	    } catch (Exception e) {
	        // Log the exception for debugging
	        e.printStackTrace(); // or use a logging framework
	        response.put("success", false);
	        response.put("message", "An error occurred: " + e.getMessage());
	    }
	    return response;
	}

	@GetMapping("/Bac-si")
	public String ourDoctor(Model model, 
	                        @RequestParam(value = "page", defaultValue = "1") int page, 
	                        @RequestParam(value = "size", defaultValue = "8") int size) {
	    // Adjust the page parameter to zero-based index for Spring Data JPA
	    Pageable pageable = PageRequest.of(page - 1, size);

	    // Fetch the paginated list of doctors
	    Page<Doctor> pageList = doctorService.getListDoctorWithPaging(pageable);

	    // Add attributes for pagination
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", pageList.getTotalPages());
	    model.addAttribute("pageList", pageList);
	    model.addAttribute("doctors", pageList.getContent());

	    return "Doctor/Page/team";
	}

	
	
	
}
