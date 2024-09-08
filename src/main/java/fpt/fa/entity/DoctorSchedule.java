package fpt.fa.entity;



import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;

import javax.persistence.ManyToOne;

import javax.persistence.Table;


@Entity
@Table(name="tbl_DoctorSchedule")
public class DoctorSchedule {
	@Id
	private int id;
	private int doctorId;
	@ManyToOne
	@JoinColumn(name="scheduleId", referencedColumnName = "id")
	private Schedule schedule;
	private boolean available;
	private String date;
	public DoctorSchedule() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getDoctorId() {
		return doctorId;
	}
	public void setDoctorId(int doctorId) {
		this.doctorId = doctorId;
	}
	public boolean isAvailable() {
		return available;
	}
	public Schedule getSchedule() {
		return schedule;
	}
	public void setSchedule(Schedule schedule) {
		this.schedule = schedule;
	}
	public void setAvailable(boolean available) {
		this.available = available;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
}
