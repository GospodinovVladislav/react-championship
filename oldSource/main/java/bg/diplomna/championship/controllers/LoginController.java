package bg.diplomna.championship.controllers;

import java.util.List;
import java.util.Map;

import javax.security.auth.Subject;
import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
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

import bg.diplomna.championship.service.UserService;
import bg.diplomna.championship.utils.PictureOperations;
import bg.diplomna.championship.validators.UserValidator;
import bg.diplomna.championship.beans.UserBean;
import bg.diplomna.championship.dao.User;

@Controller
public class LoginController {

	@Autowired
	UserValidator userValidator;
	
	@Autowired
	ServletContext context;

	@Autowired
	private UserService userService;

	@RequestMapping("/login")
	public String login(Map<String, Object> model) {
		UserBean userBean = new UserBean();
		model.put("userBean", userBean);
		return "user/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@ModelAttribute("userBean") UserBean userBean,
			BindingResult result){
		
		userValidator.validateLogin(userBean, result);
		
		if(result.hasErrors()){
			return "user/login";
		}
		
		UsernamePasswordToken token = new UsernamePasswordToken(userBean.getEmail(), userBean.getPassword());
		org.apache.shiro.subject.Subject currentUser = SecurityUtils.getSubject();
		currentUser.login(token);
		
		return "home";
	}
	
	@RequestMapping("/register")
	public String register(Map<String, Object> model){
		UserBean userBean = new UserBean();
		model.put("userBean", userBean);
		return "user/register";
	}

	@RequestMapping("/logout")
	public String logout() {

		SecurityUtils.getSubject().logout();

		return "home";
	}

	@RequestMapping("/noAccess")
	public String noAccess() {
		return "noAccess";
	}

	@RequestMapping(value = "/editMyAccount", method = RequestMethod.POST)
	public String editMyAccount(@ModelAttribute("userBean") UserBean userBean,
			BindingResult result,
			@RequestParam(value = "picture", required = false) MultipartFile image,
			Map<String,Object> model) {

		User user = userService.loadUser(userBean.getId());
		
		if(!user.getEmail().equals(userBean.getEmail())){
			userValidator.validateEmailChange(result,userBean);
		}
		
		if (!userBean.getNewPassword().equals("")) {
			if(userValidator.validatePasswordChange(result,user.getPassword(),userBean.getPassword())){
				user.setPassword(userBean.getNewPassword());
			}
		}
		userValidator.validateUserChange(result, userBean);
		
		if(result.hasErrors()){
			return "user/editMyAccount";
		}
		
		String imageName = user.getPhotoFileName();
		
		if (!image.getOriginalFilename().equals("")) {
			
			String contextPath = PictureOperations.getContextPath(context);
			imageName = PictureOperations.getImageName(image, userBean.getFirstName(), userBean.getLastName());
			String filePath = contextPath + imageName;
			

			PictureOperations.deletePicture(user.getPhotoFileName(), context);
			PictureOperations.savePicture(filePath, image);

		}

		user.setPhotoFileName(imageName);
		user.setFirstName(userBean.getFirstName());
		user.setLastName(userBean.getLastName());
		user.setEmail(userBean.getEmail());
		
		userService.saveOrUpdateUser(user);

		SecurityUtils.getSubject().logout();
//		UsernamePasswordToken token = new UsernamePasswordToken(userBean.getEmail(), userBean.getPassword());
//		org.apache.shiro.subject.Subject currentUser = SecurityUtils.getSubject();
//		currentUser.login(token);
		
		return "home";
	}

	@RequestMapping(value = "/editMyAccount", method = RequestMethod.GET)
	public String editAccount(Map<String, Object> model) {

		org.apache.shiro.subject.Subject subject = SecurityUtils.getSubject();
		User currentUser = (User) subject.getPrincipal();
		
		UserBean userBean = populateUserBean(currentUser);
		
		model.put("userBean", userBean);
		return "user/editMyAccount";
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
}
