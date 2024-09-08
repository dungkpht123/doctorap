package fpt.fa.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.*;


@Entity
@Table(name = "tbl_Doctor")
public class Doctor {

	 	@Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private int id;

	    @OneToOne
	    @JoinColumn(name = "account_id", referencedColumnName = "id")
	    private AccountEntity account;

	    @ManyToOne
	    @JoinColumn(name = "specialty_id", referencedColumnName = "id")
	    private Specialty specialty;

	    private String experience;
	    private String qualifications;
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public AccountEntity getAccount() {
			return account;
		}
		public void setAccount(AccountEntity account) {
			this.account = account;
		}
		public Specialty getSpecialty() {
			return specialty;
		}
		public void setSpecialty(Specialty specialty) {
			this.specialty = specialty;
		}
		public String getExperience() {
			return experience;
		}
		public void setExperience(String experience) {
			this.experience = experience;
		}
		public String getQualifications() {
			return qualifications;
		}
		public void setQualifications(String qualifications) {
			this.qualifications = qualifications;
		}
	    
}
