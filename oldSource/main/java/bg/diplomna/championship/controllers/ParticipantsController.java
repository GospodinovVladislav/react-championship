package bg.diplomna.championship.controllers;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.validation.Valid;

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

import bg.diplomna.championship.service.GroupsService;
import bg.diplomna.championship.service.ParticipantService;
import bg.diplomna.championship.service.ScoreService;
import bg.diplomna.championship.service.UserService;
import bg.diplomna.championship.utils.PictureOperations;
import bg.diplomna.championship.validators.ParticipantValidator;
import bg.diplomna.championship.beans.ParticipantBean;
import bg.diplomna.championship.beans.UserBean;
import bg.diplomna.championship.dao.Group;
import bg.diplomna.championship.dao.Participant;
import bg.diplomna.championship.dao.Score;
import bg.diplomna.championship.dao.User;

@Controller
@RequestMapping("/participants")
public class ParticipantsController {

	@Autowired
	private ParticipantService participantService;
	
	@Autowired
	private UserService usersService;
	
	@Autowired
	private GroupsService groupsService;
	
	@Autowired
	private ScoreService scoreService;
	
	@Autowired
	private ParticipantValidator participantValidator;
	
	@Autowired
	ServletContext context;

	@RequestMapping(method = RequestMethod.GET)
	public String listParticipants(ModelMap model) {
		
		
//		Score score = new Score();
//		
//		Group group = new Group();
//		group.setGroupName("Gang of Four New");
//		group.setStage("group");
//		
//		Participant participant = new Participant();
//		Participant participant1 = new Participant();
//		Participant participant2 = new Participant();
//		Participant participant3 = new Participant();
//		
//		participant.setFirstName("First");
//		participant.setScore(score);
//		
//		scoreService.saveOrUpdateScore(score);
//		
//		participant1.setFirstName("Second");
//		participant2.setFirstName("Third");
//		participant3.setFirstName("Forth");
//		
//		
//		groupsService.saveOrUpdateGroup(group);
//		participantService.saveOrUpdateParticipant(participant);
//		participantService.saveOrUpdateParticipant(participant1);
//		participantService.saveOrUpdateParticipant(participant2);
//		participantService.saveOrUpdateParticipant(participant3);
		
		
		model.addAttribute("participants", participantService.listAllParticipants());
		return "participant/list-participants";
	}
	
	
	@RequestMapping("/{partID}/delete")
	public String deleteParticipant(@PathVariable("partID") Long partID){
		
		Participant p = participantService.loadParticipant(partID);
		
		if(p.getScore() != null){
			Score score = p.getScore();
			score.setParticipant(null);
			scoreService.deleteScore(score.getId());
			p.setScore(null);
		}
		
		List<User> listUsers = (List<User>) usersService.listAllUsers();
		boolean isUser = false;
		
		for(User u : listUsers){
			if(p.getEmail().equals(u.getEmail())){
				isUser = true;
				u.setIsParticipant(false);
				usersService.saveOrUpdateUser(u);
				break;
			}
		}
		
		
		
		if(!isUser){
			PictureOperations.deletePicture(p.getPhotoFileName(), context);
		}
		
		
		participantService.deleteParticipant(partID);
		return "redirect:/app/participants";
	}
	
	@RequestMapping(value = "/add",method = RequestMethod.POST)
	public String addParticipant(@Valid @ModelAttribute("participantBean") ParticipantBean participantBean,
			BindingResult result,
			@RequestParam(value = "picture", required = false) MultipartFile image){
		
		participantValidator.validateEmail(participantBean, result);
		
		if(result.hasErrors()){
			return "participant/addParticipant";
		}
		
		String contextPath = PictureOperations.getContextPath(context);
		String imageName = PictureOperations.getImageName(image, participantBean.getFirstName(), participantBean.getLastName());
		String filePath = contextPath + imageName;
				
		PictureOperations.savePicture(filePath, image);
		
		Score score = new Score();
		Participant participant = new Participant();
		participant.setFirstName(participantBean.getFirstName());
		participant.setLastName(participantBean.getLastName());
		participant.setEmail(participantBean.getEmail());
		participant.setPhotoFileName(imageName);
		scoreService.saveOrUpdateScore(score);;
		participant.setScore(score);
		score.setParticipant(participant);
		participantService.saveOrUpdateParticipant(participant);
		return "redirect:/app/participants";
	}
	
	@RequestMapping(value ="/add",method = RequestMethod.GET)
	public String addParticipant(Map<String,Object> model){
		ParticipantBean participantBean = new ParticipantBean();
		
		model.put("participantBean", participantBean);
		return "participant/addParticipant";
	}
	@RequestMapping(value ="/edit/{participantID}",method = RequestMethod.GET)
	public String editParticipant(@PathVariable("participantID") long participantID,
			Map<String,Object> model){
		Participant participant = participantService.loadParticipant(participantID);
		ParticipantBean participantBean = populateParticipantBean(participant);
		
		model.put("participantBean", participantBean);
		return "participant/editParticipant";
	}
	
	private ParticipantBean populateParticipantBean(Participant participant){
		ParticipantBean participantBean = new ParticipantBean();
		participantBean.setEmail(participant.getEmail());
		participantBean.setFirstName(participant.getFirstName());
		participantBean.setLastName(participant.getLastName());
		participantBean.setId(participant.getId());
		participantBean.setPhotoFileName(participant.getPhotoFileName());
		return participantBean;
	}
	
	@RequestMapping(value = "/getParticipant", method = RequestMethod.GET)
	public @ResponseBody ParticipantBean getParticipant(@RequestParam long id) {
		ParticipantBean bean = populateParticipantBean(participantService.loadParticipant(id));
		return bean;
	}
	
	@RequestMapping(value = "/edit" ,method = RequestMethod.POST)
	public String editParticipant(@ModelAttribute("participantBean") ParticipantBean participantBean,
			BindingResult result,
			@RequestParam(value = "picture", required = false) MultipartFile image){
		Participant participant = participantService.loadParticipant(participantBean.getId());
		
		participantValidator.validateParticipantChange(result, participantBean);
		
		if(!participant.getEmail().equals(participantBean.getEmail())){
			participantValidator.validateEmailChange(result,participantBean);
		}
		
		if(result.hasErrors()){
			return "participant/editParticipant";
		}
		
		String imageName = participant.getPhotoFileName();
		if (!image.getOriginalFilename().equals("")) {
			String contextPath = PictureOperations.getContextPath(context);
			imageName = PictureOperations.getImageName(image, participantBean.getFirstName(), participantBean.getLastName());
			String filePath = contextPath + imageName;

			PictureOperations.deletePicture(participant.getPhotoFileName(), context);
			PictureOperations.savePicture(filePath, image);
		}
		participant.setFirstName(participantBean.getFirstName());
		participant.setLastName(participantBean.getLastName());
		participant.setEmail(participantBean.getEmail());
		participant.setPhotoFileName(imageName);
		participantService.saveOrUpdateParticipant(participant);
		
		return "redirect:/app/participants";
	}
	
	@RequestMapping("/addFromUsers/{userID}")
	public String addFromUsers(@PathVariable("userID") long userID){
		
//		List<Participant> participants = (List<Participant>) participantService.listAllParticipants();
		
		
//		for (Participant p : participants){
//			System.out.println(p.getEmail());
//			System.out.println(user.getEmail());
//			if(p.getEmail().equals(user.getEmail())){
//				return "alert";
//			}
//		}
		User user = usersService.loadUser(userID);
		user.setIsParticipant(true);
		usersService.saveOrUpdateUser(user);
		
		Score score = new Score();
		Participant participant = new Participant();
		participant.setFirstName(user.getFirstName());
		participant.setLastName(user.getLastName());
		participant.setEmail(user.getEmail());
		participant.setPhotoFileName(user.getPhotoFileName());
		
		scoreService.saveOrUpdateScore(score);
		
		participant.setScore(score);
		score.setParticipant(participant);

		participantService.saveOrUpdateParticipant(participant);
		
		return "redirect:/app/users";
		
	}
	
}
