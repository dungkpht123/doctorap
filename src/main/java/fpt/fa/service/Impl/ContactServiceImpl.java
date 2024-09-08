package fpt.fa.service.Impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import fpt.fa.entity.Contact;
import fpt.fa.repositories.ContactRepository;
import fpt.fa.service.ContactService;


@Service
public class ContactServiceImpl implements ContactService {

	@Autowired
	ContactRepository repository;

	@Override
	public void create(Contact contact) {
		// TODO Auto-generated method stub
		repository.save(contact);
	}

	@Override
	public void save(Contact contact) {
		repository.save(contact);
		
	}

	@Override
	public List<Contact> findAll() {
		// TODO Auto-generated method stub
		return repository.findAll();
	}

	@Override
	public Contact findById(int id) {
		// TODO Auto-generated method stub
		return repository.findById(id).orElse(null);
	}

}
