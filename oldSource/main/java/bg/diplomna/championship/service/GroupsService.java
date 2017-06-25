package bg.diplomna.championship.service;

import java.util.Collection;

import bg.diplomna.championship.dao.Group;


public interface GroupsService {

	Group loadGroup(Long id);
	
	void saveOrUpdateGroup(Group group);
	
	Collection<Group> listAllGroups();
	
	void deleteGroup(Long id);
	
	void generateQuarterFinalGroups();
	
	void generateSemiFinalsGroups();
	
	void generateFinalsGroups();
	
	Collection<Group> listGroupsByStage(String stage);
	
}
