package bg.diplomna.championship.service;

import java.util.Collection;

import bg.diplomna.championship.dao.Set;


public interface SetService {

	Set loadSet(Long id);
	
	void saveOrUpdateSet(Set set);
	
	Collection<Set> listAllSets();
	
	void deleteSet(Long id);
	
}
