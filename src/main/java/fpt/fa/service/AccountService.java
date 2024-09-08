package fpt.fa.service;

import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;
import java.time.ZoneId;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.mail.MailException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import fpt.fa.entity.AccountEntity;
import fpt.fa.entity.AllCodes;
import fpt.fa.entity.Doctor;
import fpt.fa.enums.AccountRole;
import fpt.fa.enums.Gender;
import fpt.fa.enums.StatusAccount;
import fpt.fa.repositories.AccountRepository;
import fpt.fa.repositories.AllCodeRepository;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service
@Transactional
public class AccountService {
	 private static final Logger logger = Logger.getLogger(AccountService.class.getName());
	    
	@Autowired
	private AccountRepository accountRepository;

	@Autowired
	AllCodeRepository accountRoleRepository;

	@Autowired
	private EmailService emailService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	// Lưu trữ mã xác nhận
	private Map<String, String> resetCodes = new HashMap<>();

	public AccountEntity registerNewUser(AccountEntity account) {
		account.setPassword(passwordEncoder.encode(account.getPassword()));
		account.setEmailVerificationToken(UUID.randomUUID().toString());
		accountRepository.save(account);
		sendVerificationEmail(account);
		return account;
	}
	 public AccountService(AccountRepository accountRepository) {
	        this.accountRepository = accountRepository;
	    }
	private void sendVerificationEmail(AccountEntity account) {
		String verificationLink = "http://localhost:8080/DoctorAppointment/verify?token="
				+ account.getEmailVerificationToken();
		String message = "Click the link to verify your email: " + verificationLink;
		emailService.sendEmail(account.getEmail(), "Email Verification", message);
	}

	public boolean verifyEmail(String token) {
		AccountEntity account = accountRepository.findByEmailVerificationToken(token);
		if (account != null) {
			account.setEmailVerified(true);
			account.setEmailVerificationToken(null); // XÃ³a token sau khi xÃ¡c nháº­n
			account.setStatus(StatusAccount.ACTIVE);
			AllCodes userRole = accountRoleRepository.findByRole(AccountRole.ROLE_ADMIN);
			if (userRole != null && !account.getAccountRoles().contains(userRole)) {
				account.getAccountRoles().add(userRole);
			}
			accountRepository.save(account);
			return true;
		}
		return false;
	}

	public AccountEntity findByEmail(String email) {
		return accountRepository.findByEmail(email);
	}

	// LÆ°u tÃ i khoáº£n
	public AccountEntity saveAccount(AccountEntity account) {
		return accountRepository.save(account);
	}

	// TÃ¬m tÃ i khoáº£n theo id
	public AccountEntity findAccountById(int id) {
		return accountRepository.findById(id).orElse(null);
	}

	// TÃ¬m tÃ i khoáº£n theo tÃªn ngÆ°á»�i dÃ¹ng
	public AccountEntity findAccountByUserName(String userName) {
		return accountRepository.findByUserName(userName);
	}

	// Láº¥y táº¥t cáº£ tÃ i khoáº£n
	public List<AccountEntity> findAllUsers() {
		return accountRepository.findAll();
	}

	// XÃ³a tÃ i khoáº£n theo id
	public void deleteAccount(int id) {
		accountRepository.deleteById(id);
	}

	// Cáº­p nháº­t vai trÃ² cá»§a ngÆ°á»�i dÃ¹ng
	public void updateUserRole(int userId, AccountRole newRole) {
		AccountEntity user = accountRepository.findById(userId)
				.orElseThrow(() -> new IllegalArgumentException("User not found with ID: " + userId));

		// TÃ¬m vai trÃ² trong báº£ng all_codes
		AllCodes role = accountRoleRepository.findByRole(newRole);
		if (role == null) {
			throw new IllegalArgumentException("Role not found in all_codes table: " + newRole);
		}

		// Cáº­p nháº­t vai trÃ² cá»§a ngÆ°á»�i dÃ¹ng
		List<AllCodes> roles = user.getAccountRoles();
		if (!roles.contains(role)) {
			roles.add(role); // ThÃªm vai trÃ² vÃ o danh sÃ¡ch náº¿u chÆ°a cÃ³
			user.setAccountRoles(roles);
			accountRepository.save(user); // LÆ°u thÃ´ng tin ngÆ°á»�i dÃ¹ng cáº­p nháº­t vÃ o cÆ¡ sá»Ÿ dá»¯ liá»‡u
		}
	}

	public void removeUserRole(int userId, AccountRole role) {
		AccountEntity account = accountRepository.findById(userId)
				.orElseThrow(() -> new IllegalArgumentException("User not found"));

		// TÃ¬m vai trÃ² cáº§n xÃ³a
		AllCodes roleToRemove = account.getAccountRoles().stream().filter(r -> r.getRole().equals(role)).findFirst()
				.orElseThrow(() -> new IllegalArgumentException("Role not found for this user"));

		// XÃ³a vai trÃ²
		account.getAccountRoles().remove(roleToRemove);

		// LÆ°u cáº­p nháº­t
		accountRepository.save(account);
	}

	public void updateAccountInfo(AccountEntity account, String image) {
		// Kiá»ƒm tra xem tÃ i khoáº£n cÃ³ tá»“n táº¡i khÃ´ng
		if (account.getId() == 0) {
			throw new IllegalArgumentException("User ID must be provided.");
		}

		// Láº¥y ngÆ°á»�i dÃ¹ng hiá»‡n táº¡i tá»« db
		AccountEntity existingAccount = accountRepository.findById(account.getId())
				.orElseThrow(() -> new RuntimeException("User not found"));

		// Cáº­p nháº­t thÃ´ng tin ngÆ°á»�i dÃ¹ng
		existingAccount.setUserName(account.getUserName());
		existingAccount.setPhoneNumber(account.getPhoneNumber());
		existingAccount.setAddress(account.getAddress());
		existingAccount.setGender(account.getGender());
		if (image.isEmpty() || image != null) {
			existingAccount.setAvatar(image);
		} else {
			existingAccount.setAvatar(account.getAvatar());
		}
		// Cáº­p nháº­t máº­t kháº©u
		if (account.getPassword() != null && !account.getPassword().isEmpty()) {
			existingAccount.setPassword(passwordEncoder.encode(account.getPassword()));
		}

		accountRepository.save(existingAccount);
	}

	public void updatePassword(AccountEntity account) {
		// Retrieve the existing account from the database
		AccountEntity existingAccount = accountRepository.findById(account.getId())
				.orElseThrow(() -> new RuntimeException("User not found"));

		// Update the password
		if (account.getPassword() != null && !account.getPassword().isEmpty()) {
			existingAccount.setPassword(passwordEncoder.encode(account.getPassword()));
		}

		// Save the updated account
		accountRepository.save(existingAccount);
	}

	public AccountEntity addUser(AccountEntity accountEntity) {
		return accountRepository.save(accountEntity);
	}

	public void deleteUser(int id) {
		accountRepository.deleteById(id);
	}

	public AccountEntity updateUser(AccountEntity accountEntity) {
		return accountRepository.save(accountEntity);
	}

	public AccountEntity findByPhoneNumber(String phoneNumber) {
		return accountRepository.findByPhoneNumber(phoneNumber);
	}

	public List<AccountEntity> findUsersByRole(AccountRole role) {
		return accountRepository.findByAccountRolesRole(role);
	}

	public List<AccountEntity> getAllDoctors() {
		return accountRepository.findAllDoctors();
	}

	public boolean sendResetCode(String email) {
		AccountEntity account = accountRepository.findByEmail(email);
		if (account == null) {
			return false; // Email address not found
		}

		String resetCode = generateResetCode();
		resetCodes.put(email, resetCode);

		String subject = "Password Reset Code";
		String message = "Your reset code is: " + resetCode;

		try {
			emailService.sendEmail(email, subject, message);
			return true;
		} catch (MailException e) {
			e.printStackTrace();
			return false; // Handle email sending failure
		}
	}

	public boolean resetPassword(String email, String resetCode, String newPassword) {
		// Check if new password and confirm password match
		String storedCode = resetCodes.get(email);
		if (storedCode != null && storedCode.equals(resetCode)) {
			AccountEntity account = accountRepository.findByEmail(email);
			if (account != null) {
				account.setPassword(passwordEncoder.encode(newPassword));
				accountRepository.save(account);
				resetCodes.remove(email); // Remove the code once used
				return true; // Password reset successful
			}
		}
		return false; // Invalid reset code or email
	}

	private String generateResetCode() {
		Random random = new Random();
		int code = 100000 + random.nextInt(900000); // Generate a 6-digit code
		return Integer.toString(code);
	}

	// thêm tài khoản
	public void addAccount(String email, String password, String userName, AccountRole role) {
		// Ma hoa password
		String encodedPassword = passwordEncoder.encode(password);

		AccountEntity account = new AccountEntity();
		account.setEmail(email);
		account.setPassword(encodedPassword);
		account.setUserName(userName);
		account.setEmailVerified(true);
		account.setStatus(StatusAccount.ACTIVE);

		// Tim role tu allcode
		AllCodes accountRole = accountRoleRepository.findByRole(role);
		if (accountRole == null) {
			throw new IllegalArgumentException("Invalid role: " + role);
		}

		// Them Role vao List
		List<AllCodes> roles = new ArrayList<>();
		roles.add(accountRole);
		account.setAccountRoles(roles);

		accountRepository.save(account);
	}

	public void deleteAccountById(int id) {
		if (!accountRepository.existsById(id)) {
			throw new IllegalArgumentException("User not found with ID: " + id);
		}

		accountRepository.deleteById(id);
	}

	public AccountEntity UpdateRole() {
		Pageable pageable = PageRequest.of(0, 1, Sort.by(Sort.Direction.DESC, "id"));
		return accountRepository.findAll(pageable).getContent().stream().findFirst().orElse(null);
	}

	// tính tổng số user và phần trăm số lượng người đăng ký ngày hôm nay
	// Method to get the total number of users
	public long getTotalNumberOfUsers() {
		return accountRepository.count();
	}

	// Method to get the number of users who registered today
	public long getUsersRegisteredToday() {
		return accountRepository.countUsersRegisteredToday();
	}

	// Method to calculate the percentage of users who registered today
	public double getPercentageOfUsersRegisteredToday() {
		long totalUsers = getTotalNumberOfUsers();
		long usersToday = getUsersRegisteredToday();

		if (totalUsers == 0) {
			return 0;
		}
		double percentage = ((double) usersToday / totalUsers) * 100;

		// Round the result to two decimal places
		return Math.round(percentage * 100.0) / 100.0;
	}

	// Method to get the number of users who registered in the current year

	public LocalDate getEarliestRegistrationDate() {
		Timestamp earliestTimestamp = accountRepository.findEarliestRegistrationDate();
		return earliestTimestamp.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
	}

	



	public void updateAccount(int id, String userName, String email, String phoneNumber, String address, Gender gender,
			String password, StatusAccount status, List<String> roles) throws Exception {

		// Tìm người dùng theo ID
		AccountEntity account = accountRepository.findById(id)
				.orElseThrow(() -> new Exception("User not found with ID: " + id));

		// Cập nhật thông tin người dùng
		account.setUserName(userName);
		account.setEmail(email);
		account.setPhoneNumber(phoneNumber);
		account.setAddress(address);
		account.setGender(gender);
		account.setStatus(status);
		// Cập nhật mật khẩu nếu có
		if (password != null && !password.isEmpty()) {
			account.setPassword(passwordEncoder.encode(password));
		}

		// Cập nhật vai trò mới
		List<AllCodes> newRoles = new ArrayList<>();
		for (String role : roles) {
			AllCodes accountRole = accountRoleRepository.findByRole(AccountRole.valueOf(role));
			if (accountRole == null) {
				throw new IllegalArgumentException("Invalid role: " + role);
			}
			newRoles.add(accountRole);
		}
		account.setAccountRoles(newRoles);

		// Lưu thông tin người dùng đã cập nhật vào cơ sở dữ liệu
		accountRepository.save(account);
	}
	  public Map<String, Long> getDailyUserCountsByRole(LocalDate startDate, LocalDate endDate, AccountRole role) {
	        Map<String, Long> dailyCounts = new HashMap<>();
	        LocalDate currentDate = startDate;

	        while (!currentDate.isAfter(endDate)) {
	            // Bắt đầu ngày (00:00:00)
	            Date startDateOfDay = Date.valueOf(currentDate);
	            // Bắt đầu ngày kế tiếp (00:00:00 của ngày kế tiếp)
	            Date endDateOfDay = Date.valueOf(currentDate.plusDays(1));

	            long count = accountRepository.countByRoleAndCreatedAtBetween(role, startDateOfDay, endDateOfDay);
	            dailyCounts.put(currentDate.toString(), count);
	            currentDate = currentDate.plusDays(1);
	        }

	        return dailyCounts;
	    }

	    // Thêm phương thức để tính tổng số lượng người dùng theo vai trò
	    public long getTotalNumberOfUsersByRole(AccountRole role) {
	        return accountRepository.countByRole(role);
	    }

}