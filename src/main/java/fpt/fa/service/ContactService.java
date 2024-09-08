package fpt.fa.service;

import java.util.List;

import fpt.fa.entity.Contact;

public interface ContactService {
	void create(Contact contact);
	void save(Contact contact);
	List<Contact> findAll();
	Contact findById(int id);

}
