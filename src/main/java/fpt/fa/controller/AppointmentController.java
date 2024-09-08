package fpt.fa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;
import fpt.fa.entity.Appointment;
import fpt.fa.entity.DoctorSchedule;
import fpt.fa.entity.Schedule;
import fpt.fa.service.AppointmentServices;
import fpt.fa.service.DoctorScheduleServices;
import fpt.fa.service.ScheduleServices;

import java.util.ArrayList;
import java.util.List;
@Controller
@RequestMapping("/admin")
public class AppointmentController {
	@Autowired
	AppointmentServices appointmentServices;
	@Autowired
	ScheduleServices scheduleServices;
	@Autowired
	DoctorScheduleServices doctorScheduleServices;
	@Autowired
    private JavaMailSender mailSender;
	@GetMapping("/AppointmentList")
	public String List(Model model,@RequestParam(name = "upage", required = false,defaultValue ="1") int upage,
			@RequestParam(name = "ppage", required = false,defaultValue ="1") int ppage) {
		int size = 6;
		Page<Appointment> appointment = appointmentServices.adminAppointmentsUpcoming(PageRequest.of(upage - 1, size));
		Page<Appointment> pastappointment = appointmentServices.adminAppointmentsPast(PageRequest.of(ppage - 1, 4));
		model.addAttribute("upcoming", appointment);
		model.addAttribute("upage",upage);
		model.addAttribute("past", pastappointment);
		model.addAttribute("ppage",ppage);
		
		return "Admin/Page/Appointment/List";
	}
	
	

	
	
	@GetMapping("/AppointmentAdd")
	public String Add(Model model) {
		model.addAttribute("newAppointment", new Appointment());
		return "Admin/Page/Appointment/Add";
	}

	@PostMapping("/send-email")
	@ResponseBody
	public ResponseEntity<?> sendEmail(@RequestParam("id") int id) {
	    try {
	        boolean success = appointmentServices.sendAppointmentEmail(id);
	        Map<String, String> response = new HashMap<>();
	        if (success) {
	            response.put("message", "Email đã được gửi");
	            return ResponseEntity.ok(response);
	        } else {
	            response.put("message", "Gửi email không thành công");
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	        }
	    } catch (Exception e) {
	        Map<String, String> response = new HashMap<>();
	        response.put("message", "Không tìm thấy tài nguyên: " + e.getMessage());
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
	    } 
	}


	
	
	////////////// draft
}
