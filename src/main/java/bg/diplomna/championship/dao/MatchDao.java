package bg.diplomna.championship.dao;

import java.util.Collection;

public interface MatchDao {

	void saveOrUpdate(Match match);

	Match load(Long id);
	
	Collection<Match> listAll();
	
	void deleteMatch(Long id);
	
}
