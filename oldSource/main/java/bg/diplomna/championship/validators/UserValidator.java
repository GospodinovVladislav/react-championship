package bg.diplomna.championship.validators;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindingResult;

import bg.diplomna.championship.beans.UserBean;
import bg.diplomna.championship.dao.User;
import bg.diplomna.championship.service.UserService;

@Component
public class UserValidator{
	
	@Autowired
	UserService userService;
	
	private final String EMAIL_REGEX = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
		+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	
	private boolean regExMailValidation(String email){
		Pattern pattern = Pattern.compile(EMAIL_REGEX);
		Matcher matcher = pattern.matcher(email);
		return matcher.matches();
	}
	
	public void validateUserChange(BindingResult result,UserBean userBean){
		
		if(!regExMailValidation(userBean.getEmail())){
			result.rejectValue("email", "error.user", "Invalid email!");
		}
		
		if(userBean.getFirstName().isEmpty()){
			result.rejectValue("firstName", "error.user", "Enter first name!");
		}
		
		if(userBean.getLastName().isEmpty()){
			result.rejectValue("lastName", "error.user", "Enter last name!");
		}
	}
	
	public void validateEmailChange(BindingResult result,UserBean userBean){
		List<User> users = (List<User>) userService.listAllUsers();
		
		for (User u : users){
			if(u.getEmail().equals(userBean.getEmail()) && u.getId() != userBean.getId()){
				result.rejectValue("email", "error.user", "Email already exists!");
			}
		}
	}
	
	public boolean validatePasswordChange(BindingResult result,String userPassword,String beanPassword){
		if(userPassword.equals(beanPassword)){
			return true;
		}
		result.rejectValue("password", "error.user", "Wrong password!");
		return false;
	}
	
	public void validateLogin(UserBean user,BindingResult result){
		User emailMatch = null;
		List<User> users = (List<User>) userService.listAllUsers();
		
		for (User u : users){
			if(user.getEmail().equals(u.getEmail())){
				emailMatch = u;
				break;
			}
		}
		if(emailMatch == null || !emailMatch.getPassword().equals(user.getPassword())){
			result.rejectValue("email", "error.user", "User name or password incorect");
		}
		
	}
	
	public void validateEmail(UserBean user, BindingResult result) {
		if(emailExists(user.getEmail())){
			result.rejectValue("email", "error.user", "Email already exists!");
		}
		if(!regExMailValidation(user.getEmail())){
			result.rejectValue("email", "error.user", "Invalid email!");
		}
	}
	
	private boolean emailExists(String email){
		List<User> users = (List<User>) userService.listAllUsers();
		for(User user : users){
			if(email.equals(user.getEmail())){
				return true;
			}
		}
		return false;
	}
}
