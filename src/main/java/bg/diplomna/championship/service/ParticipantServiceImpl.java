package bg.diplomna.championship.service;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import bg.diplomna.championship.dao.Participant;
import bg.diplomna.championship.dao.ParticipantDao;


@Service
@Transactional
public class ParticipantServiceImpl implements ParticipantService {
	
	@Autowired
	private ParticipantDao participantDao;

	@Override
	public Participant loadParticipant(Long id) {
		return participantDao.load(id);
	}

	@Override
	public void saveOrUpdateParticipant(Participant participant) {
		participantDao.saveOrUpdate(participant);
	}

	@Override
	public Collection<Participant> listAllParticipants() {
		return participantDao.listAll();
	}

	@Override
	public void deleteParticipant(Long id) {
		participantDao.deleteParticipant(id);
	}
	
}
