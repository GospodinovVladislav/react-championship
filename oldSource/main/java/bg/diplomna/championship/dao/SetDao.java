package bg.diplomna.championship.dao;

import java.util.Collection;

public interface SetDao {

	void saveOrUpdate(Set set);

	Set load(Long id);
	
	Collection<Set> listAll();
	
	void deleteSet(Long id);
	
}
