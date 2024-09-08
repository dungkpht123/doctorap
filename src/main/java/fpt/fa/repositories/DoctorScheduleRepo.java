package fpt.fa.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import fpt.fa.entity.DoctorSchedule;

public interface DoctorScheduleRepo extends JpaRepository<DoctorSchedule, Integer>{

}
