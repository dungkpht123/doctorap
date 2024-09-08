package fpt.fa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Controller
public class EmailController {

    @Autowired
    private JavaMailSender mailSender;


    
    @GetMapping("/sendEmail")
    public String sendEmail() {
		/*
		 * try { MimeMessage mimeMessage = mailSender.createMimeMessage();
		 * MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
		 * 
		 * helper.setFrom("dungkpht@gmail.com"); helper.setTo("dungkpht@gmail.com");
		 * helper.setSubject("Test mail"); helper.setText("This is test contemt", true);
		 * // true for HTML content
		 * 
		 * mailSender.send(mimeMessage); } catch (MessagingException e) {
		 * e.printStackTrace(); return new ModelAndView("Admin/Page/Mail/SendMail",
		 * "message", "Failed to send email!"); }
		 */

        return "Admin/Page/Mail/SendMail";
    }
}
