package fpt.fa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import fpt.fa.entity.Contact;
import fpt.fa.service.ContactService;

@Controller
public class ContactAdminController {

    @Autowired
    private ContactService contactService;

    @RequestMapping(value = "/admin/hien-thi-lien-he", method = RequestMethod.GET)
    public String lienhe(Model model) {
        List<Contact> contacts = contactService.findAll();
        model.addAttribute("contacts", contacts);
        return "Admin/Page/Contact/ContactList";
    }
}