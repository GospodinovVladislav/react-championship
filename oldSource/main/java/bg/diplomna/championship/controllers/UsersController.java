package bg.diplomna.championship.controllers;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import bg.diplomna.championship.service.ParticipantService;
import bg.diplomna.championship.service.UserService;
import bg.diplomna.championship.utils.PictureOperations;
import bg.diplomna.championship.validators.UserValidator;
import javassist.Loader;
import bg.diplomna.championship.beans.UserBean;
import bg.diplomna.championship.dao.Participant;
import bg.diplomna.championship.dao.User;

@Controller
@RequestMapping("/users")
public class UsersController {

	@Autowired
	private UserValidator userValidator;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ParticipantService participantService;

	@Autowired
	ServletContext context;

	@RequestMapping(method = RequestMethod.GET)
	public String listUsers(ModelMap model) {

//		 User user = new User();
//		
//		 user.setFirstName("Gosho");
//		 user.setLastName("Petrov");
//		 user.setEmail("mail@mails.bg");
//		 user.setPassword("1234");
//		
//		 userService.saveOrUpdateUser(user);
		
		model.addAttribute("users", userService.listAllUsers());
		return "user/list-users";
	}

	@RequestMapping("/{userID}/delete")
	public String deleteUser(@PathVariable("userID") Long userID) {

		User user = userService.loadUser(userID);
		
		if(!user.getIsParticipant()){
			PictureOperations.deletePicture(user.getPhotoFileName(), context);
		}

		userService.deleteUser(userID);
		return "redirect:/app/users";
	}
	
	@RequestMapping(value = "/getUser", method = RequestMethod.GET)
	public @ResponseBody UserBean getUser(@RequestParam long id) {
		UserBean bean = populateUserBean(userService.loadUser(id));
		return bean;
	}
	

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addUser(@Valid @ModelAttribute("userBean") UserBean userBean,
			BindingResult result,
			@RequestParam(value = "picture", required = false) MultipartFile image) {

		userValidator.validateEmail(userBean, result);
		
		if(result.hasErrors()){
			return "user/register";
		}
		
		String contextPath = PictureOperations.getContextPath(context);
		String imageName = PictureOperations.getImageName(image, userBean.getFirstName(), userBean.getLastName());
		String filePath = contextPath + imageName;
				
		PictureOperations.savePicture(filePath, image);

		User user = new User();

		user.setFirstName(userBean.getFirstName());
		user.setLastName(userBean.getLastName());
		user.setEmail(userBean.getEmail());
		user.setPhotoFileName(imageName);
		user.setPassword(userBean.getPassword());

		userService.saveOrUpdateUser(user);

		UsernamePasswordToken token = new UsernamePasswordToken(userBean.getEmail(), userBean.getPassword());
		org.apache.shiro.subject.Subject currentUser = SecurityUtils.getSubject();
		currentUser.login(token);

		return "redirect:/app/users";
	}
	
	

	private UserBean populateUserBean(User currentUser){
		UserBean userBean = new UserBean();
		
		userBean.setAdmin(currentUser.getIsAdmin());
		userBean.setEmail(currentUser.getEmail());
		userBean.setFirstName(currentUser.getFirstName());
		userBean.setId(currentUser.getId());
		userBean.setLastName(currentUser.getLastName());
		userBean.setPassword(currentUser.getPassword());
		userBean.setNewPassword(currentUser.getPassword());
		userBean.setPhotoFileName(currentUser.getPhotoFileName());
		
		return userBean;
	}
	
	@RequestMapping("/{userID}/openForEdit")
	public String openForEdit(@PathVariable("userID") long userID,
			Map<String,Object> model) {

		User user = userService.loadUser(userID);
		UserBean userBean = populateUserBean(user);

		model.put("userBean", userBean);
		model.put("isAdmin", user.getIsAdmin());
		return "user/editUser";
	}

	@RequestMapping("/edit")
	public String editUser(@ModelAttribute("userBean") UserBean userBean,
			BindingResult result,
			@RequestParam(value = "picture", required = false) MultipartFile image,
			@RequestParam(value = "checkboxes", required = false) String userIds) {
		User user = userService.loadUser(userBean.getId());
		
		
		userValidator.validateUserChange(result, userBean);
		
		if(!user.getEmail().equals(userBean.getEmail())){
			userValidator.validateEmailChange(result,userBean);
		}
		
		if(result.hasErrors()){
			return "user/editUser";
		}
		
		String imageName = user.getPhotoFileName();
		if (!image.getOriginalFilename().equals("")) {
			String contextPath = PictureOperations.getContextPath(context);
			imageName = PictureOperations.getImageName(image, userBean.getFirstName(), userBean.getLastName());
			String filePath = contextPath + imageName;

			PictureOperations.deletePicture(user.getPhotoFileName(), context);
			PictureOperations.savePicture(filePath, image);
		}

		if (userIds != null) {
			if (userIds.equals("Admin")) {
				user.setAdmin(true);
			}
		} else {
			user.setAdmin(false);
		}

		user.setPhotoFileName(imageName);
		user.setFirstName(userBean.getFirstName());
		user.setLastName(userBean.getLastName());
		user.setEmail(userBean.getEmail());
		userService.saveOrUpdateUser(user);

		//editParticipant(user);
		
		return "redirect:/app/users";
	}
	
	
	private void editParticipant(User user){
		Participant participant = null;
		
		List<Participant> listParticipants = (List<Participant>) participantService.listAllParticipants();
		
		for(Participant p : listParticipants){
			if(p.getEmail().equals(user.getEmail())){
				participant = participantService.loadParticipant(p.getId());
			}
		}
		
		if(participant != null){
			participant.setFirstName(user.getFirstName());
			participant.setLastName(user.getLastName());
			participant.setPhotoFileName(user.getPhotoFileName());
		}
	}

}
