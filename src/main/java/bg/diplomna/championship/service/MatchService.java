package bg.diplomna.championship.service;

import java.util.Collection;

import bg.diplomna.championship.dao.Group;
import bg.diplomna.championship.dao.Match;


public interface MatchService {

	Match loadMatch(Long id);
	
	void saveOrUpdateMatch(Match match);
	
	Collection<Match> listAllMatches();
	
	void deleteMatch(Long id);
	
	void generateMatches(Group group);
	
	void generateQuarterFinalsMatches(Group group);
	
	void generateSemiFinalsMatches(Group group);
	
	void generateFinalsMatches(Group group);
}
