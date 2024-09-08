package fpt.fa.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import fpt.fa.entity.Post;
import fpt.fa.entity.Specialty;
import fpt.fa.repositories.SpecialtyRepo;
import fpt.fa.service.SpecialtyServices;
@Service
public class SpecialtyServicesImpl implements SpecialtyServices{
	@Autowired
	SpecialtyRepo repo;
	@Override
	public void Add(Specialty specialty) {
		// TODO Auto-generated method stub
		repo.save(specialty);
	}

	@Override
	public List<Specialty> ShowSpecialtyList() {
		return repo.findAll(Sort.by(Sort.Order.desc("id")));
	}

	@Override
	public void delete(Specialty specialty) {
		repo.delete(specialty);
	}

	@Override
	public void edit(Specialty specialty) {
		if(specialty.getImage().isEmpty() || specialty.getImage()==null) {
			Specialty s = repo.findById(specialty.getId()).orElse(null);		
			specialty.setImage(s.getImage());
		}
		repo.save(specialty);
	}

	@Override
	public Specialty FindId(int id) {
		return repo.findById(id).orElse(null);
	}

	@Override
	public List<Specialty> showSpecialtyLimit(int limit) {
		Pageable pageable = PageRequest.of(0, limit,Sort.by(Sort.Order.desc("id")));
		Page<Specialty> specialPage = repo.findAll(pageable);
		return specialPage.getContent();
        }


	@Override
	public Page<Specialty> getListSpecWithPaging(Pageable pageable) {
	    return repo.findAll(pageable);
	}
	  @Override
	    public Page<Specialty> searchSpecialtiesByName(String name, Pageable pageable) {
	        return repo.findByNameContainingIgnoreCase(name, pageable);
	    }


	    public List<Specialty> getAllSpecialties() {
	        return repo.findAll();
	    }
}
