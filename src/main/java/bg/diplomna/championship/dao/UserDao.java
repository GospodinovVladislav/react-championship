package bg.diplomna.championship.dao;

import java.util.Collection;

public interface UserDao {

	
	void saveOrUpdate(User user);

	User load(Long id);
	
	Collection<User> listAll();
	
	void deleteUser(Long id);

}
