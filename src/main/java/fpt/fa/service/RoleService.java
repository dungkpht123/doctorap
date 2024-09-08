package fpt.fa.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import fpt.fa.entity.AllCodes;
import fpt.fa.enums.AccountRole;
import fpt.fa.repositories.AllCodeRepository;
@Service
@Transactional

public class RoleService {
	@Autowired
	AllCodeRepository accountRoleRepository;
	
	public AllCodes findByRole(AccountRole accountRole) {
		return accountRoleRepository.getAccountRoleByRole(accountRole);
	}
	
	// Lưu vai trò
    public AllCodes saveRole(AllCodes role) {
        return accountRoleRepository.save(role);
    }

    // Tìm vai trò theo id
    public AllCodes findRoleById(int id) {
        return accountRoleRepository.findById(id).orElse(null);
    }

    // Tìm vai trò theo tên vai trò
    public AllCodes findRoleByRole(AccountRole role) {
        return accountRoleRepository.findByRole(role);
    }

    // Lấy tất cả vai trò
    public List<AllCodes> findAllRoles() {
        return accountRoleRepository.findAll();
    }

    // Xóa vai trò theo id
    public void deleteRole(int id) {
    	accountRoleRepository.deleteById(id);
    }
}

