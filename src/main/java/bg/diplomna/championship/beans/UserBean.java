package bg.diplomna.championship.beans;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class UserBean {

	private long id;
	private boolean isAdmin;
	private String photoFileName;
	
	@Size(min = 6, max = 15, message = "Your password must between 6 and 15 characters")
	private String newPassword;
	
	@NotEmpty(message = "Enter name!")
	private String firstName;
	
	@NotEmpty(message = "Enter last name!")
	private String lastName;
	
	@NotEmpty(message = "Enter email")
	@Email(message = "Wrong format email")
	private String email;
	
	@NotEmpty(message = "Enter password")
	@Size(min = 6, max = 15, message = "Your password must between 6 and 15 characters")
	private String password;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhotoFileName() {
		return photoFileName;
	}

	public void setPhotoFileName(String photoFileName) {
		this.photoFileName = photoFileName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	
	
}
