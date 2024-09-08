package fpt.fa.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fpt.fa.entity.AdminMenu;
import fpt.fa.repositories.AdminMenuRepo;
import fpt.fa.service.AdminMenuServices;
@Service
public class AdminMenuServicesImpl implements AdminMenuServices{
	@Autowired
	AdminMenuRepo repo;
	@Override
	public List<AdminMenu> AdminMenuList() {
		// TODO Auto-generated method stub
		return repo.findAll();
	}
	
}
