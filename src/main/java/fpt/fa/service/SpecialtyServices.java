package fpt.fa.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import fpt.fa.entity.Specialty;

public interface SpecialtyServices {
	void Add(Specialty specialty);
	List<Specialty> ShowSpecialtyList();
	List<Specialty> showSpecialtyLimit(int limit);
	void delete(Specialty specialty);
	void edit(Specialty specialty);
	Specialty FindId(int id);
	Page<Specialty> getListSpecWithPaging(Pageable pageable);
	Page<Specialty> searchSpecialtiesByName(String name, Pageable pageable);
	List<Specialty> getAllSpecialties();
}
