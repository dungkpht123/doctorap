package fpt.fa.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import fpt.fa.entity.Contact;

@Repository
public interface ContactRepository extends JpaRepository<Contact, Integer> {
	
}