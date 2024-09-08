package fpt.fa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import java.util.List;

import fpt.fa.entity.Specialty;
import fpt.fa.service.SpecialtyServices;

@ControllerAdvice
public class MenuFooterController {
	
	@Autowired 
	SpecialtyServices services;
	
	@ModelAttribute("FooterService")
	public List<Specialty> footer(){
		List<Specialty> specialties = services.getAllSpecialties();
		return specialties;
	}
	
}
