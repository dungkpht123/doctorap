package fpt.fa.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import fpt.fa.entity.Appointment;
import fpt.fa.entity.Doctor;
import fpt.fa.entity.Specialty;
import fpt.fa.service.AppointmentServices;
import fpt.fa.service.DoctorService;
import fpt.fa.service.ScheduleServices;
import fpt.fa.service.SpecialtyServices;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class PatientAppointmentController {
	@Autowired
	ScheduleServices scheduleServices;
	@Autowired
	AppointmentServices appointmentServices;
	@Autowired
	SpecialtyServices specialtyServices;
	@Autowired
	DoctorService doctorService;
	@GetMapping("SpecialtyList-all")
	public String SpecialtyIndex(Model model) {
		model.addAttribute("specialtyList",specialtyServices.ShowSpecialtyList());
		return "Doctor/Page/Specialty";
	}
	
	
	@GetMapping("appointment/booking")
	public String Appointment(Model model, @RequestParam("doctorid") int id, @RequestParam(value = "error",required = false) boolean error) {
		if (error) {
			model.addAttribute("error", "Thời gian khám không hợp lệ");
		}
		model.addAttribute("scheduleList", scheduleServices.ShowList());
		model.addAttribute("appointment", new Appointment());
		model.addAttribute("doc", doctorService.getDoctorById(id));
		model.addAttribute("now", LocalDate.now());
		
		return "Doctor/Page/appointment";
		}
	@PostMapping("appointment/booking")
	public String Appointment(Model model,@ModelAttribute("appointment") Appointment appointment,RedirectAttributes redirectAttributes,HttpServletRequest request) {
		int id = appointment.getDoctor().getId();
		if(!appointmentServices.available(appointment)) {
			return "redirect: booking?doctorid="+id+"&error=true";
		}
		else if(appointment.getAccount().getId()==1) {
			String date = appointment.getDate();
			int time = appointment.getSchedule().getId();
			appointmentServices.Add(appointment);
			return "redirect:/appointment-ticket?doctor="+id+"&date="+date+"&time="+time;
		}
		else {
			appointmentServices.Add(appointment);
			return "redirect:/your-appointment";
		}
	}
	
	@GetMapping("/doctorlist")
	public String getMethodName(@RequestParam("specialtyid") int id, Model model) {
		model.addAttribute("doctors", doctorService.getDoctorBySpecialty(id));
		return "Doctor/Page/doctorlist";
	}
	@GetMapping("/your-appointment")
	public String getMethodName(Model model, HttpSession session) {
		int id =(int) session.getAttribute("userId");
		model.addAttribute("appointments", appointmentServices.yourAppointments(id));
		return "Doctor/Page/your-appointment";
	}
	@GetMapping("/patient-cancel")
	public String cancel(Model model,@RequestParam("appointmentid") int id) {
		appointmentServices.canceled(id);
		return "redirect: your-appointment";
	}
	@GetMapping("/appointment-ticket")
	public String ticket(Model model,@RequestParam("doctor") int id,@RequestParam("date") String date, @RequestParam("time") int time) {
		model.addAttribute("ticket", appointmentServices.ticket(id, date, time));
		return "Doctor/Page/appointment-ticket";
	}
	
	@GetMapping("/appointment_with_extra_step")
	public String man(Model model,@RequestParam(value = "error",required = false) boolean error)
	{
		if (error) {
			model.addAttribute("error", "Thời gian khám không hợp lệ");
		}
		model.addAttribute("scheduleList", scheduleServices.ShowList());
		model.addAttribute("appointment", new Appointment());
		model.addAttribute("now", LocalDate.now());
		model.addAttribute("slist", specialtyServices.ShowSpecialtyList());
		model.addAttribute("dlist", doctorService.getAllDoctors());
		
		
		return "Doctor/Page/cooler-appointment";
	}
	
	@PostMapping("/appointment_with_extra_step")
	public String man(Model model,@ModelAttribute("appointment") Appointment appointment,RedirectAttributes redirectAttributes,HttpServletRequest request) {
		int id = appointment.getDoctor().getId();
		if(!appointmentServices.available(appointment)) {
			return "redirect: appointment_with_extra_step?error=true";
		}
		else if(appointment.getAccount().getId()==1) {
			String date = appointment.getDate();
			int time = appointment.getSchedule().getId();
			appointmentServices.Add(appointment);
			return "redirect:/appointment-ticket?doctor="+id+"&date="+date+"&time="+time;
		}
		else {
			appointmentServices.Add(appointment);
			return "redirect:/your-appointment";
		}
	}
}
