
/*package fpt.fa.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import fpt.fa.entity.Doctor;
import fpt.fa.enums.AccountRole;
import fpt.fa.repositories.DoctorRepository;
import fpt.fa.service.DoctorService;

import java.util.List;

@Service
public class DoctorServiceImpl implements DoctorService {

    @Autowired
    private DoctorRepository doctorRepository;

    @Override
    public Doctor saveDoctor(Doctor doctor) {
        return doctorRepository.save(doctor);
    }

    @Override
    public Doctor getDoctorById(int id) {
        return doctorRepository.findById(id).orElse(null);
    }

    @Override
    public List<Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }

    @Override
    public void deleteDoctor(int id) {
        doctorRepository.deleteById(id);
    }

	@Override
	public List<Doctor> findDoctorsByRole(AccountRole role) {
		// TODO Auto-generated method stub
		return null;
	}
    

   
}
*/




