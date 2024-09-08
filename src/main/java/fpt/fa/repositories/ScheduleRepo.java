package fpt.fa.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import fpt.fa.entity.Schedule;

public interface ScheduleRepo extends JpaRepository<Schedule, Integer>{

}
