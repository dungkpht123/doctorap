package fpt.fa.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import fpt.fa.entity.AllCodes;
import fpt.fa.enums.AccountRole;

@Repository
public interface AllCodeRepository extends CrudRepository<AllCodes, Integer> { 
	public AllCodes getAccountRoleByRole(AccountRole accountRole);
	AllCodes findByRole(AccountRole accountRole);
	List<AllCodes> findAll();
	// Lấy tất cả vai trò theo danh sách id
    List<AllCodes> findAllById(List<Integer> roleIds);
    
}
