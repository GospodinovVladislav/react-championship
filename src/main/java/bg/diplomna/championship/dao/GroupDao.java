package bg.diplomna.championship.dao;

import java.util.Collection;

public interface GroupDao {

	void saveOrUpdate(Group group);

	Group load(Long id);
	
	Collection<Group> listAll();
	
	void deleteGroup(Long id);
	
	Collection<Group> getGroupsByStage(String stage);
}
