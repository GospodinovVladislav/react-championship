package bg.diplomna.championship.service;

import java.util.Collection;

import bg.diplomna.championship.dao.Participant;

public interface ParticipantService {
	
	Participant loadParticipant(Long id);
	
	void saveOrUpdateParticipant(Participant participant);
	
	Collection<Participant> listAllParticipants();
	
	void deleteParticipant(Long id);
}
