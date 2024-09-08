package fpt.fa.service;

import java.util.List;

import fpt.fa.entity.DoctorSchedule;

public interface DoctorScheduleServices {
	List<DoctorSchedule> List();
	void Add(DoctorSchedule doctorSchedule);
}
