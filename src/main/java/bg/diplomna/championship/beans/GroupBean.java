package bg.diplomna.championship.beans;

import org.hibernate.validator.constraints.NotEmpty;

public class GroupBean {

	
	private long id;
	
	@NotEmpty
	private String groupName;
	
	private int numberParticipants;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public int getNumberParticipants() {
		return numberParticipants;
	}

	public void setNumberParticipants(int numberParticipants) {
		this.numberParticipants = numberParticipants;
	}
}
