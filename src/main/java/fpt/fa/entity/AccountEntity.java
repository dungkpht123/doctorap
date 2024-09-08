package fpt.fa.entity;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.*;
import fpt.fa.enums.Gender;
import fpt.fa.enums.StatusAccount;

@Entity
@Table(name = "tbl_users")
public class AccountEntity  implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String userName;
    private String phoneNumber;
    private String address;
    private String email;
    @Enumerated(EnumType.STRING)
    private Gender gender;
    private String password;
    private String avatar;
    @Enumerated(EnumType.STRING)
    private StatusAccount status = StatusAccount.BLOCK;
    private String emailVerificationToken;
    private boolean isEmailVerified = false;
    @Column(name = "created_at", updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "updated_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt;
    // Relationship to Doctor entity
    @OneToOne(mappedBy = "account", cascade = CascadeType.REMOVE)
    private Doctor doctor;

    
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "acc_role_relationship",
        joinColumns = @JoinColumn(name = "acc_id", referencedColumnName = "id"),
        inverseJoinColumns = @JoinColumn(name = "acc_role_id", referencedColumnName = "id"))
    private List<AllCodes> accountRoles;

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public StatusAccount getStatus() {
		return status;
	}

	public void setStatus(StatusAccount status) {
		this.status = status;
	}

	public String getEmailVerificationToken() {
		return emailVerificationToken;
	}

	public void setEmailVerificationToken(String emailVerificationToken) {
		this.emailVerificationToken = emailVerificationToken;
	}

	public boolean isEmailVerified() {
		return isEmailVerified;
	}

	public void setEmailVerified(boolean isEmailVerified) {
		this.isEmailVerified = isEmailVerified;
	}

	public List<AllCodes> getAccountRoles() {
		return accountRoles;
	}

	public void setAccountRoles(List<AllCodes> accountRoles) {
		this.accountRoles = accountRoles;
	}
	
	@PrePersist
	public void getCreatedAt() {
		createdAt = new Date();
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	
	 @PreUpdate
	public void getUpdatedAt() {
		 updatedAt = new Date();
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	// Getter for createdAt as a LocalDate
    @Transient
    public java.time.LocalDate getLocalCreatedAt() {
        return new java.sql.Date(createdAt.getTime()).toLocalDate();
    }

    // Getter for updatedAt as a LocalDate
    @Transient
    public java.time.LocalDate getLocalUpdatedAt() {
        return new java.sql.Date(updatedAt.getTime()).toLocalDate();
    }

   
}
