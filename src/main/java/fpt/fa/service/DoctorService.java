package fpt.fa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import fpt.fa.entity.Doctor;
import fpt.fa.entity.AccountEntity;
import fpt.fa.entity.AllCodes;
import fpt.fa.repositories.AccountRepository;
import fpt.fa.repositories.AllCodeRepository;
import fpt.fa.repositories.DoctorRepository;
import fpt.fa.enums.AccountRole;
import java.util.Collections;

import java.util.List;
import java.util.Set;

@Service
public class DoctorService {

	@Autowired
	private DoctorRepository doctorRepository;
	@Autowired
	private AccountRepository accountRepository;
	@Autowired
	private AllCodeRepository allCodesRepository;

	public List<Doctor> findDoctorsByRole(AccountRole role) {
		AllCodes roleEntity = allCodesRepository.findByRole(role);
		if (roleEntity != null) {
			// Implement logic to filter doctors based on role if needed
			// This example assumes that all doctors are returned
			return doctorRepository.findAll();
		}
		return Collections.emptyList(); // Return an empty list if no roles match
	}

	

	public void saveDoctor(Doctor doctor) {
		doctorRepository.save(doctor);
	}

	public Doctor getDoctorById(int id) {
		return doctorRepository.findById(id).orElse(null);
	}

	
	public void deleteDoctor(int doctorId) {
        doctorRepository.deleteById(doctorId);
    }
	 public Doctor getDoctorByAccountId(int accountId) {
	        return doctorRepository.findByAccountId(accountId);
	    }
	// Lấy danh sách bác sĩ
    public List<Doctor> getAllDoctors() {
        // Lấy các bác sĩ có role là ROLE_DOCTOR
        return doctorRepository.findByAccount_AccountRoles_Role(AccountRole.ROLE_DOCTOR);
    }
    public void updateDoctor(Doctor doctor) {
        Doctor existingDoctor = doctorRepository.findById(doctor.getId()).orElse(null);
        if (existingDoctor != null) {
            existingDoctor.setSpecialty(doctor.getSpecialty());
            existingDoctor.setExperience(doctor.getExperience());
            existingDoctor.setQualifications(doctor.getQualifications());
            doctorRepository.save(existingDoctor);
        }
    }
	public List<Doctor> getDoctorBySpecialty(int id) {
		return doctorRepository.doctorSpecialtyList(id);
	}

	  public int getTotalNumberOfDoctors() {
	        return (int) doctorRepository.count();
	    }
	   // Add this method to return a paginated list of doctors
    public Page<Doctor> getListDoctorWithPaging(Pageable pageable) {
        return doctorRepository.findAll(pageable);
    }

   
    public void SetDoctorAcc(int id) {
		Doctor doctor = new Doctor();
	    AccountEntity acc = accountRepository.findById(id).orElse(null);

	    if (acc != null) {
	        doctor.setAccount(acc);
	        saveDoctor(doctor);
	    }
	}
}
