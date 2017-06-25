package bg.diplomna.championship.beans;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class ParticipantBean {

	private long id;
	private boolean isInGroup;
	private String photoFileName;
	
	@NotEmpty(message = "Enter name!")
	private String firstName;
	
	@NotEmpty(message = "Enter name!")
	private String lastName;
	
	@NotEmpty(message = "Enter email")
	@Email(message = "Wrong format email")
	private String email;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public boolean getIsInGroup() {
		return isInGroup;
	}

	public void setInGroup(boolean isInGroup) {
		this.isInGroup = isInGroup;
	}

	public String getPhotoFileName() {
		return photoFileName;
	}

	public void setPhotoFileName(String photoFileName) {
		this.photoFileName = photoFileName;
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
	
	
	
	
}
