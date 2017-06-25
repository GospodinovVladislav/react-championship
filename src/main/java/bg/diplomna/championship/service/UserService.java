package bg.diplomna.championship.service;

import java.util.Collection;

import bg.diplomna.championship.dao.User;


public interface UserService {

	
	User loadUser(Long id);
	
	void saveOrUpdateUser(User user);
	
	Collection<User> listAllUsers();
	
	void deleteUser(Long id);
}
