package fpt.fa.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import fpt.fa.service.AppointmentServices;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/doctor")
public class DoctorAppointmentController {
	@Autowired
	AppointmentServices appointmentServices;
	@GetMapping("/Appointmentlist-all")
	public String AppointmentList(Model model, HttpSession session) {
		model.addAttribute("upcoming", appointmentServices.upcomingAndCurrent((int) session.getAttribute("userId")));
		model.addAttribute("past", appointmentServices.past((int) session.getAttribute("userId")));
		
		
		return "Doctor/Page/doctor/AppointmentList";
	}
	
	@GetMapping("/Appointmentlist-current")
	public String Appointmentcurrent(Model model, HttpSession session) {
		
		model.addAttribute("current", appointmentServices.current((int) session.getAttribute("userId")));
		return "Doctor/Page/doctor/CurrentAppointment";
	}
	
	@GetMapping("/Appointmentlist-upcoming")
	public String AppointmentListupcoming(Model model, HttpSession session) {
		int i = (int) session.getAttribute("userId");
		System.out.println(i);
		model.addAttribute("upcoming", appointmentServices.upcoming(i));
		return "Doctor/Page/doctor/UpcomingAppointment";
	}
	@GetMapping("/appointment-success")
	public String success(@RequestParam("id") int id) {
		appointmentServices.success(id);
		return "redirect: Appointmentlist-current";
	}
	@GetMapping("/appointment-canceled")
	public String canceled(@RequestParam("id") int id) {
		appointmentServices.canceled(id);
		return "redirect: Appointmentlist-current";
	}
}
