package fpt.fa.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import fpt.fa.entity.Appointment;

public interface AppointmentRepo extends JpaRepository<Appointment, Integer>{

	@Query("SELECT e FROM Appointment e WHERE e.date = :date AND e.schedule.id = :time")
    List<Appointment> availability(@Param("date") String date, @Param("time") int time);
	
	@Query("select e from Appointment e where e.date < :date order by e.date asc")
	List<Appointment> past(@Param("date") String date);
	
	@Query("select e from Appointment e where e.date >= :date order by e.date asc")
	List<Appointment> upcomingAndCurrent(@Param("date") String date);
	
	@Query("select e from Appointment e where e.date > :date order by e.date asc, e.schedule.id asc")
	List<Appointment> upcoming(@Param("date") String date);
	
	@Query("select e from Appointment e where e.date = :date order by e.date asc, e.schedule.id asc")
	List<Appointment> current(@Param("date") String date);
	@Query("SELECT e FROM Appointment e WHERE e.doctor.id= :id and e.date = :date AND e.schedule.id = :time")
    List<Appointment> availability(@Param("id") int id,@Param("date") String date, @Param("time") int time);
	
	@Query("select e from Appointment e where e.doctor.account.id= :id and e.date < :date order by e.date asc, e.schedule.id asc")
	List<Appointment> past(@Param("date") String date,@Param("id") int id);
	
	@Query("select e from Appointment e where e.doctor.account.id= :id and e.date >= :date order by e.date asc, e.schedule.id asc")
	List<Appointment> upcomingAndCurrent(@Param("date") String date,@Param("id") int id);
	
	@Query("select e from Appointment e where e.doctor.account.id= :id and e.date > :date order by e.date asc, e.schedule.id asc")
	List<Appointment> upcoming(@Param("date") String date,@Param("id") int id);
	
	@Query("select e from Appointment e where e.doctor.account.id= :id and e.date = :date order by e.date asc, e.schedule.id asc")
	List<Appointment> current(@Param("date") String date,@Param("id") int id);
	
	@Query("select e from Appointment e where e.account.id = :id and e.date >= :date order by e.date asc, e.schedule.id asc")
	List<Appointment> yourappointment(@Param("date") String date,@Param("id") int id);
	
	@Query("select e from Appointment e where e.account.id = :id and e.date < :date order by e.date asc, e.schedule.id asc")
	List<Appointment> yourpastappointment(@Param("date") String date,@Param("id") int id);
	
	@Query("select e from Appointment e where e.doctor.id = :id and e.date = :date and e.schedule.id= :time")
	Appointment ticket(@Param("id") int id,@Param("date") String date,@Param("time") int time);
	
	@Query("select e from Appointment e where e.date < :date order by e.date asc, e.schedule.id asc")
	Page<Appointment> AAP(@Param("date") String date, Pageable pageable);
	
	@Query("select e from Appointment e where e.date >= :date order by e.date asc, e.schedule.id asc")
	Page<Appointment> AAU(@Param("date") String date, Pageable pageable);

}
