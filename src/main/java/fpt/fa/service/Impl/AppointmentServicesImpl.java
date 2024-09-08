package fpt.fa.service.Impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.annotations.Where;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import fpt.fa.entity.Appointment;
import fpt.fa.entity.Schedule;
import fpt.fa.enums.AppointmentStatus;
import fpt.fa.repositories.AppointmentRepo;
import fpt.fa.repositories.DoctorScheduleRepo;
import fpt.fa.service.AppointmentServices;
@Service
public class AppointmentServicesImpl implements AppointmentServices{
	@Autowired
	AppointmentRepo repo;
	@Autowired
	 private JavaMailSender mailSender;
	@Override
	public List<Appointment> List() {
		// TODO Auto-generated method stub
		return repo.findAll();
	}

	@Override
	public void Add(Appointment appointment) {
		appointment.setAppointmentStatus(AppointmentStatus.BOOKED);
		repo.save(appointment);
		
	}

	@Override
	public boolean available(Appointment appointment) {
		int time = appointment.getSchedule().getId();
		List<Appointment> a= repo.availability(appointment.getDoctor().getId(),appointment.getDate(),time);
		if(a.size()!=0) {
			return false;
		}
		return true;
	}

	@Override
	public List<Appointment> upcomingAndCurrent(int id) {
		String now = java.time.LocalDate.now().toString();
		return repo.upcomingAndCurrent(now,id);
	}

	@Override
	public List<Appointment> past(int id) {
		String now = java.time.LocalDate.now().toString();
		return repo.past(now,id);
	}

	@Override
	public java.util.List<Appointment> upcoming(int id) {
		String now = java.time.LocalDate.now().toString();
		return repo.upcoming(now,id);
	}

	@Override
	public java.util.List<Appointment> current(int id) {
		String now = java.time.LocalDate.now().toString();
		return repo.current(now,id);
	}

	@Override
	public void success(int id) {
		Appointment a = find(id);
		a.setAppointmentStatus(AppointmentStatus.SUCCESS);
		repo.save(a);
		
	}

	@Override
	public void canceled(int id) {
		Appointment a = find(id);
		a.setAppointmentStatus(AppointmentStatus.CANCELED);
		repo.save(a);
		
	}

	@Override
	public Appointment find(int id) {
		return repo.findById(id).orElse(null);
	}

	@Override
	public java.util.List<Appointment> yourAppointments(int id) {
		String now = java.time.LocalDate.now().toString();
		return repo.yourappointment(now,id); //turboflex appointment
	}

	@Override
	public Appointment ticket(int id, String date, int time) {
		
		return repo.ticket(id, date, time);
	}

	@Override
	public Page<Appointment> adminAppointmentsUpcoming(Pageable pageable) {
		String now = java.time.LocalDate.now().toString();
		return repo.AAU(now,pageable);
	}

	@Override
	public Page<Appointment> adminAppointmentsPast(Pageable pageable) {
		String now = java.time.LocalDate.now().toString();
		return repo.AAP(now,pageable);
	}

	@Override
	@Transactional
	public boolean sendAppointmentEmail(int id) {
		try {
            // Lấy thông tin lịch khám từ cơ sở dữ liệu
            Appointment appointment = repo.findById(id)
                    .orElseThrow(() -> new RuntimeException("Lịch khám không tồn tại"));

            // Tạo thông điệp email
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(appointment.getPatientEmail());
            message.setSubject("Thông tin lịch khám");
            message.setText("Chi tiết lịch khám:\n" +
                            "Bác sĩ: " + appointment.getDoctor().getAccount().getUserName() + "\n" +
                            "Bệnh nhân: " + appointment.getPatientName() + "\n" +
                            "Ngày khám: " + appointment.getDate() + "\n" +
                            "Giờ khám: " + appointment.getSchedule().getSchedule() + "\n" +
                            "Triệu chứng: " + appointment.getDescription());

            // Gửi email
            mailSender.send(message);

            // Cập nhật trạng thái email đã gửi
            appointment.setEmailSent(true);
            repo.save(appointment);

            return true;
        } catch (Exception e) {
            // Xử lý lỗi gửi email hoặc cập nhật cơ sở dữ liệu
            e.printStackTrace();
            return false;
        }
    }
	


}
