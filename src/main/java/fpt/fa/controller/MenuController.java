package fpt.fa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import fpt.fa.entity.AdminMenu;
import fpt.fa.service.AdminMenuServices;

@ControllerAdvice
public class MenuController {
	@Autowired
	AdminMenuServices adminMenuServices;
	@ModelAttribute("AdminMenu")
	public List<AdminMenu> AdminMenu(){
		List<AdminMenu> adminMenu = adminMenuServices.AdminMenuList();
		return adminMenu; 
	}
}
