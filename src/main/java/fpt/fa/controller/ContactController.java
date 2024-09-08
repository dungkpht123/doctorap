package fpt.fa.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import fpt.fa.entity.AccountEntity;
import fpt.fa.entity.Contact;
import fpt.fa.service.AccountService;
import fpt.fa.service.ContactService;

@Controller
public class ContactController {
	
	@Autowired
	private ContactService contactService;

	
	@Autowired
	private AccountService accountService;
	
	@RequestMapping(value = "lien-he", method = RequestMethod.GET)
	public String lienhe(Model model) {
		 
		return "Doctor/Page/contact";
	}
	
	@RequestMapping(value = "lien-he", method = RequestMethod.POST)
    public String handleFormSubmission(@RequestParam String subject, 
                                       @RequestParam String message, 
                                       HttpSession session) {
        // Lấy thông tin tài khoản từ session
        AccountEntity account = (AccountEntity) session.getAttribute("account");

        // Tạo đối tượng Contact và thiết lập thông tin
        Contact contact = new Contact();
        contact.setSubject(subject);
        contact.setMessage(message);
        contact.setAccount(account); // Gán tài khoản vào Contact
        
        // Lưu thông tin vào cơ sở dữ liệu
        contactService.save(contact);
        
        // Thêm thông báo thành công vào model
        session.setAttribute("message", "Thông tin đã được gửi thành công!");
        
        // Chuyển hướng về trang liên hệ
        return "redirect:/lien-he";
    }
	
	@Autowired
    private JavaMailSender emailSender;

    @PostMapping("/xuly-phan-hoi")
    public String handleResponse(@RequestParam("contactId") int contactId,
                                 @RequestParam("response") String response,
                                 @RequestParam("email") String email,
                                 Model model) {
        Contact contact = contactService.findById(contactId);

        if (contact != null) {
            // Gửi email phản hồi
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("Phản hồi từ hệ thống");
            message.setText("Chúng tôi đã nhận được phản hồi của bạn:\n\n" + response);
            emailSender.send(message);

            model.addAttribute("successMessage", "Phản hồi đã được gửi.");
        } else {
            model.addAttribute("errorMessage", "Không tìm thấy liên hệ.");
        }

        return "Admin/Page/Contact/ResponseSuccess"; // Hoặc trang nào bạn muốn hiển thị thông báo thành công
    }	
}
