package fpt.fa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fpt.fa.entity.Schedule;
import fpt.fa.repositories.ScheduleRepo;

@Service
public class ScheduleServices {
	@Autowired
	ScheduleRepo repo;
	public List<Schedule> ShowList(){
		return repo.findAll();
	}
}
