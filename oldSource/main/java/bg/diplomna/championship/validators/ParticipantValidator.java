package bg.diplomna.championship.validators;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindingResult;

import bg.diplomna.championship.beans.ParticipantBean;
import bg.diplomna.championship.beans.UserBean;
import bg.diplomna.championship.dao.Participant;
import bg.diplomna.championship.dao.User;
import bg.diplomna.championship.service.ParticipantService;
import bg.diplomna.championship.service.UserService;

@Component
public class ParticipantValidator {

	@Autowired
	ParticipantService participantService;
	
	@Autowired
	UserService userService;
	
	private final String EMAIL_REGEX = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
			+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	
public void validateParticipantChange(BindingResult result,ParticipantBean participantBean){
		
		if(!regExMailValidation(participantBean.getEmail())){
			result.rejectValue("email", "error.user", "Invalid email!");
		}
		
		if(participantBean.getFirstName().isEmpty()){
			result.rejectValue("firstName", "error.user", "Enter first name!");
		}
		
		if(participantBean.getLastName().isEmpty()){
			result.rejectValue("lastName", "error.user", "Enter last name!");
		}
	}
	
	public void validateEmailChange(BindingResult result,ParticipantBean participantBean){
		List<Participant> participants = (List<Participant>) participantService.listAllParticipants();
		
		for (Participant part : participants){
			if(part.getEmail().equals(participantBean.getEmail()) && part.getId() != participantBean.getId()){
				result.rejectValue("email", "error.user", "Email already exists!");
			}
		}
		if(emailExistsInUsers(participantBean.getEmail())){
			result.rejectValue("email", "error.user", "There is user with that email!");
		}
	}
	
	public void validateEmail(ParticipantBean participantBean, BindingResult result) {
		if(emailExists(participantBean.getEmail())){
			result.rejectValue("email", "error.user", "Email already exists!");
		}
		if(!regExMailValidation(participantBean.getEmail())){
			result.rejectValue("email", "error.user", "Invalid email!");
		}
		if(emailExistsInUsers(participantBean.getEmail())){
			result.rejectValue("email", "error.user", "There is user with that email!");
		}
	}
	
	private boolean emailExistsInUsers(String email){
		List<User> users = (List<User>) userService.listAllUsers();
		for(User u:users){
			if(u.getEmail().equals(email)){
				return true;
			}
		}
		return false;
	}
	
	private boolean emailExists(String email){
		List<Participant> participants = (List<Participant>) participantService.listAllParticipants();
		for(Participant part : participants){
			if(email.equals(part.getEmail())){
				return true;
			}
		}
		return false;
	}
	
	private boolean regExMailValidation(String email){
		Pattern pattern = Pattern.compile(EMAIL_REGEX);
		Matcher matcher = pattern.matcher(email);
		return matcher.matches();
	}
	
}
