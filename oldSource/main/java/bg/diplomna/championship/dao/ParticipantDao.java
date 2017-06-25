package bg.diplomna.championship.dao;

import java.util.Collection;

public interface ParticipantDao {

	void saveOrUpdate(Participant participant);

	Participant load(Long id);
	
	Collection<Participant> listAll();
	
	void deleteParticipant(Long id);

}