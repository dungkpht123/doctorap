package fpt.fa.repositories;

import fpt.fa.entity.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import fpt.fa.enums.AccountRole;

import java.util.List;

@Repository
public interface DoctorRepository extends JpaRepository<Doctor, Integer> {
    List<Doctor> findAllById(List<Integer> ids); // Method to find doctors by a list of IDs
    @Query("SELECT e FROM Doctor e WHERE e.specialty.id = :id order by e.id asc")
    List<Doctor> doctorSpecialtyList(@Param("id") int id);
    	

 // Custom query to count the total number of doctors
    @Query("SELECT COUNT(e) FROM Doctor e")
    int getTotalNumberOfDoctors();

    
    List<Doctor> findByAccount_AccountRoles_Role(AccountRole role);
    Doctor findByAccountId(int accountId);
}
