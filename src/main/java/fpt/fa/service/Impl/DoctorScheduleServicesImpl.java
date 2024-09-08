package fpt.fa.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import fpt.fa.entity.DoctorSchedule;
import fpt.fa.repositories.DoctorScheduleRepo;
import fpt.fa.service.DoctorScheduleServices;
@Service
public class DoctorScheduleServicesImpl implements DoctorScheduleServices{
	@Autowired
	DoctorScheduleRepo repo;
	@Override
	public List<DoctorSchedule> List() {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public void Add( DoctorSchedule doctorSchedule) {
		
		doctorSchedule.setAvailable(true);
		repo.save(doctorSchedule);
		
	}
	
}
