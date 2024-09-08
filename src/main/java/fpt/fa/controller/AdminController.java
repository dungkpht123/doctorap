package fpt.fa.controller;

import fpt.fa.entity.AccountEntity;
import fpt.fa.entity.AllCodes;
import fpt.fa.entity.Doctor;
import fpt.fa.enums.AccountRole;
import fpt.fa.enums.Gender;
import fpt.fa.enums.StatusAccount;
import fpt.fa.repositories.AllCodeRepository;
import fpt.fa.service.AccountService;
import fpt.fa.service.DoctorService;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AdminController {
	@Autowired
	AccountService accountService;
	@Autowired
	AllCodeRepository accountRoleRepository;
	@Autowired
	DoctorService doctorService;

	@RequestMapping(value = { "/admin" }, method = RequestMethod.GET)
	public String showAdminPage(HttpSession session, Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();

		if (auth != null && auth.isAuthenticated() && !(auth.getPrincipal() instanceof String)) {
			AccountEntity account = (AccountEntity) auth.getPrincipal();
			String username = account.getUserName();
			session.setAttribute("username", username); // Lưu vào session
		} else {
			session.setAttribute("username", "Guest");
		}
		// Get total number of doctors and add it to the model
		long totalDoctors = doctorService.getTotalNumberOfDoctors();
		model.addAttribute("totalDoctors", totalDoctors);

		// Get total number of users
		long totalUsers = accountService.getTotalNumberOfUsers();
		model.addAttribute("totalUsers", totalUsers);
		long totolUserToday = accountService.getUsersRegisteredToday();
		model.addAttribute("totaltoday",totolUserToday);
		
		double percentageToday = accountService.getPercentageOfUsersRegisteredToday();
		model.addAttribute("percentageToday", percentageToday);

		return "Admin/Page/index";
	}

	@RequestMapping(value = { "/profiletest" }, method = RequestMethod.GET)
	public String profilePage(Model model) {
		return "Admin/Page/Profile/Profile";
	}

	@RequestMapping(value = "admin/quan-ly-tai-khoan", method = RequestMethod.GET)
	public String defaultAfterLogin(Model model) {
		model.addAttribute("users", accountService.findAllUsers());
		return "Admin/Page/ManagerAcount/ListAccount";
	}

//	@RequestMapping(value = "/assignRole", method = RequestMethod.POST)
//	public String assignRole(@RequestParam("userId") int userId, @RequestParam("role") String roleName, Model model) {
//		try {
//			AccountRole role = AccountRole.valueOf(roleName);
//			accountService.updateUserRole(userId, role);
//			model.addAttribute("message", "Role updated successfully!");
//		} catch (IllegalArgumentException e) {
//			model.addAttribute("message", "Invalid role specified or role not found.");
//		}
//		return "redirect:/quan-ly-tai-khoan";
//	}
//
//	@RequestMapping(value = "/removeRole", method = RequestMethod.POST)
//	public String removeRole(@RequestParam("userId") int userId, @RequestParam("role") String roleName, Model model) {
//		try {
//			AccountRole role = AccountRole.valueOf(roleName);
//			accountService.removeUserRole(userId, role);
//			model.addAttribute("message", "Role removed successfully!");
//		} catch (IllegalArgumentException e) {
//			model.addAttribute("message", "Invalid role specified or role not found.");
//		}
//
//		return "redirect:/quan-ly-tai-khoan"; // Redirect về trang admin sau khi xóa role
//	}


	@RequestMapping(value = "admin/quan-ly-tai-khoan/add", method = RequestMethod.POST)
	public String addUser(@RequestParam("email") String email,
	                      @RequestParam("password") String password,
	                      @RequestParam("userName") String userName,
	                      @RequestParam("role") String role,
	                      RedirectAttributes redirectAttributes) {
	    try {
	        // Kiểm tra email và username có tồn tại chưa
	        if (accountService.findByEmail(email) != null) {
	            redirectAttributes.addFlashAttribute("errorMessage", "Email already exists.");
	            return "redirect:/admin/quan-ly-tai-khoan";
	        }
	        if (accountService.findAccountByUserName(userName) != null) {
	            redirectAttributes.addFlashAttribute("errorMessage", "Username already exists.");
	            return "redirect:/admin/quan-ly-tai-khoan";
	        }

	        // Thêm tài khoản
	        AccountRole accountRole = AccountRole.valueOf(role);
	        accountService.addAccount(email, password, userName, accountRole);

	        // Kiểm tra nếu vai trò là bác sĩ thì thêm vào bảng bác sĩ
	        if (accountRole == AccountRole.ROLE_DOCTOR) {
	            AccountEntity account = accountService.findByEmail(email);
	            doctorService.SetDoctorAcc(account.getId());
	        }

	        redirectAttributes.addFlashAttribute("successMessage", "User added successfully.");
	    } catch (Exception e) {
	        redirectAttributes.addFlashAttribute("errorMessage", "Error adding user: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return "redirect:/admin/quan-ly-tai-khoan";
	}



	 @RequestMapping(value = "admin/quan-ly-tai-khoan/delete/{id}", method = RequestMethod.GET)
	    public String deleteUser(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
	        try {
	            accountService.deleteAccountById(id);
	            redirectAttributes.addFlashAttribute("successMessage", "User deleted successfully.");
	        } catch (IllegalArgumentException e) {
	            redirectAttributes.addFlashAttribute("errorMessage", "Error: " + e.getMessage());
	        }
	        return "redirect:/admin/quan-ly-tai-khoan";
	    }
	@RequestMapping(value = "admin/quan-ly-tai-khoan/update/{id}", method = RequestMethod.GET)
	 public String showUpdateForm(@PathVariable("id") int id, Model model) {
	     AccountEntity user = accountService.findAccountById(id);
	     if (user != null) {
	    	 List<AllCodes> allRoles = accountRoleRepository.findAll();
	    	 
	    	 model.addAttribute("roles", allRoles);
	         model.addAttribute("user", user);
	         return "Admin/Page/ManagerAcount/UpdateAccount";
	     } else {
	         model.addAttribute("message", "User not found.");
	         return "redirect:/quan-ly-tai-khoan";
	     }
	 }
	
	@RequestMapping(value = "admin/quan-ly-tai-khoan/update", method = RequestMethod.POST)
	public String updateUser(@RequestParam("id") int id,
	                         @RequestParam("userName") String userName,
	                         @RequestParam("email") String email,
	                         @RequestParam("phoneNumber") String phoneNumber,
	                         @RequestParam("address") String address,
	                         @RequestParam("gender") Gender gender,
	                         @RequestParam(value = "password", required = false) String password,
	                         @RequestParam("status") StatusAccount status,
	                         @RequestParam("roles") List<String> roles,
	                         RedirectAttributes redirectAttributes) {
	    try {
	        
	        AccountEntity existingEmailAccount = accountService.findByEmail(email);
	        if (existingEmailAccount != null && existingEmailAccount.getId() != id) {
	            redirectAttributes.addFlashAttribute("errorMessage", "Email already exists.");
	            return "redirect:/quan-ly-tai-khoan/update/" + id;
	        }

	        AccountEntity existingUserNameAccount = accountService.findAccountByUserName(userName);
	        if (existingUserNameAccount != null && existingUserNameAccount.getId() != id) {
	            redirectAttributes.addFlashAttribute("errorMessage", "Username already exists.");
	            return "redirect:/quan-ly-tai-khoan/update/" + id;
	        }

	        AccountEntity existingPhoneNumberAccount = accountService.findByPhoneNumber(phoneNumber);
	        if (existingPhoneNumberAccount != null && existingPhoneNumberAccount.getId() != id) {
	            redirectAttributes.addFlashAttribute("errorMessage", "Phone number already exists.");
	            return "redirect:/quan-ly-tai-khoan/update/" + id;
	        }
	        
	        accountService.updateAccount(id, userName, email, phoneNumber, address, gender, password, status, roles);

	        boolean hasDoctorRole = roles.contains("ROLE_DOCTOR");

	        if (hasDoctorRole) {
	            doctorService.SetDoctorAcc(id);
	        } else {
	            Doctor doctor = doctorService.getDoctorByAccountId(id);
	            if (doctor != null) {
	                doctorService.deleteDoctor(doctor.getId());
	            }
	        }

	        redirectAttributes.addFlashAttribute("successMessage", "User updated successfully.");
	    } catch (Exception e) {
	        redirectAttributes.addFlashAttribute("errorMessage", "Error updating user: " + e.getMessage());
	    }
	    return "redirect:/admin/quan-ly-tai-khoan";
	}



}
