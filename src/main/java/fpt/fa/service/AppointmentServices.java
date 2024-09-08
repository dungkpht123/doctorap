package fpt.fa.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import fpt.fa.entity.Appointment;
import fpt.fa.entity.Schedule;

public interface AppointmentServices {
	List<Appointment> List();
	void Add(Appointment appointment);
	boolean available(Appointment appointment);
	List<Appointment> upcoming(int id);
	List<Appointment> past(int id);
	List<Appointment> upcomingAndCurrent(int id);
	List<Appointment> current(int id);
	void success(int id);
	void canceled(int id );
	Appointment find(int id);
	List<Appointment> yourAppointments(int id);
	Appointment ticket(int id, String date, int time);
	Page<Appointment> adminAppointmentsUpcoming(Pageable pageable);
	Page<Appointment> adminAppointmentsPast(Pageable pageable);
	boolean sendAppointmentEmail(int id);
}
