package fpt.fa.repositories;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import fpt.fa.entity.AccountEntity;
import fpt.fa.entity.Doctor;
import fpt.fa.enums.AccountRole;
import java.sql.Timestamp;

@Repository
public interface AccountRepository extends JpaRepository<AccountEntity, Integer> {
    AccountEntity findByEmail(String email);
    AccountEntity findByEmailVerificationToken(String token);
    AccountEntity findByUserName(String userName);
    List<AccountEntity> findAll();
    AccountEntity findByPhoneNumber(String phoneNumber);
    List<AccountEntity> findByAccountRolesRole(AccountRole role);
    List<Doctor> findAllById(List<Integer> ids); // If you need to find doctors by a list of IDs
    @Query("SELECT a FROM AccountEntity a JOIN a.accountRoles ar WHERE ar.role = fpt.fa.enums.AccountRole.ROLE_DOCTOR")
    List<AccountEntity> findAllDoctors();
    
    // Method to count the total number of users
    long count();

    // Custom query to count the number of users who registered today
    @Query("SELECT COUNT(a) FROM AccountEntity a WHERE DATE(a.createdAt) = CURRENT_DATE")
    long countUsersRegisteredToday();
 
    @Query("SELECT COUNT(a) FROM AccountEntity a")
    long countTotalUsers();

    // Count users registered on a specific date
    @Query("SELECT COUNT(a) FROM AccountEntity a WHERE a.createdAt = :date")
    long countByCreatedAt(@Param("date") LocalDate date);

    @Query("SELECT COUNT(a) FROM AccountEntity a WHERE a.createdAt >= :date AND a.createdAt < :nextDate")
    long countByCreatedAtBetween(@Param("date") Date date, @Param("nextDate") Date nextDate);
    @Query("SELECT MIN(a.createdAt) FROM AccountEntity a")
    Timestamp findEarliestRegistrationDate();

 
    // Truy vấn để đếm người dùng với vai trò cụ thể trong khoảng thời gian
    @Query("SELECT COUNT(a) FROM AccountEntity a JOIN a.accountRoles ar WHERE ar.role = :role AND a.createdAt >= :startDate AND a.createdAt < :endDate")
    long countByRoleAndCreatedAtBetween(@Param("role") AccountRole role, @Param("startDate") Date startDate, @Param("endDate") Date endDate);

    // Thêm truy vấn để đếm người dùng với vai trò cụ thể không theo khoảng thời gian
    @Query("SELECT COUNT(a) FROM AccountEntity a JOIN a.accountRoles ar WHERE ar.role = :role")
    long countByRole(@Param("role") AccountRole role);
}
