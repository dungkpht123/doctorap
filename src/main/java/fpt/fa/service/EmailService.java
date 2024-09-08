package fpt.fa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import fpt.fa.repositories.AllCodeRepository;

@Service
@Transactional
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;
    @Autowired
	AllCodeRepository accountRoleRepository;
    public void sendEmail(String to, String subject, String text) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setSubject(subject);
        message.setText(text);
        mailSender.send(message);
    }

}
