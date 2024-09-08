package fpt.fa.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import fpt.fa.entity.Specialty;

public interface SpecialtyRepo extends JpaRepository<Specialty, Integer>{
	 Page<Specialty> findByNameContainingIgnoreCase(String name, Pageable pageable);
	 }