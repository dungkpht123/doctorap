package fpt.fa.entity;

import javax.persistence.*;
import fpt.fa.enums.AccountRole;

@Entity
@Table(name = "all_codes")
public class AllCodes {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Enumerated(EnumType.STRING)
    private AccountRole role = AccountRole.ROLE_USER;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public AccountRole getRole() {
		return role;
	}

	public void setRole(AccountRole role) {
		this.role = role;
	}
	 @Override
	    public String toString() {
	        return "AllCodes{" +
	                "id=" + id +
	                ", role=" + role +
	                '}';
	    }
    
}
