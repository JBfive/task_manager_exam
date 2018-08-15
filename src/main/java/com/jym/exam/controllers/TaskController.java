package com.jym.exam.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jym.exam.models.Task;
import com.jym.exam.models.User;
import com.jym.exam.services.TaskService;
import com.jym.exam.validator.UserValidator;

@Controller
public class TaskController {
	private final TaskService tServ;
	private final UserValidator userValidator;
	
	public TaskController(TaskService tServ, UserValidator userValidator) {
		this.tServ = tServ;
		this.userValidator = userValidator;
	}
	
	@RequestMapping("/")
	 public String home(@ModelAttribute("users") User user) {
		 
		 return "index.jsp";
	 }
	
	@RequestMapping(value="/registration", method=RequestMethod.POST)
    public String registerUser(@Valid @ModelAttribute("users") User user, BindingResult result, HttpSession session) {
    	userValidator.validate(user, result); 
        if(result.hasErrors()) {
        	return "index.jsp";
        }
        User u = tServ.registerUser(user);
        session.setAttribute("userId", u.getId()); //this used to be user ID stuff. Don't save as a full user object, it causes issues later. Always save as userId
        return"redirect:/tasks";
    }
    
    @RequestMapping(value="/login", method=RequestMethod.POST)
    public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, @ModelAttribute("users") User user, Model model, HttpSession session) {
        boolean isAuthenticated = tServ.authenticateUser(email, password);
        if(isAuthenticated) {
        	User u = tServ.findByEmail(email);
        	session.setAttribute("userId", u.getId()); //see above
        	return "redirect:/tasks";
        } else {
        	model.addAttribute("error", "Invalid Credentials. Please try again.");
        	return "index.jsp";
        }
        
    }
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
    @RequestMapping("/delete/{id}")
    public String destroy(@PathVariable("id") Long id) {
    	tServ.deleteTask(id);
    
    
    return "redirect:/tasks";
    }
    
    @RequestMapping("/tasks")
    public String displayAll(@ModelAttribute("tasks") Task task, Model model, HttpSession session) {
    	if(session.getAttribute("userId") == null) {
    		return "redirect:/";
    	}
    	List<Task> all =tServ.allTasks();
    	model.addAttribute("tasks", all);
    	Long u = (Long) session.getAttribute("userId");
    	User name = tServ.findUserById(u);
    	model.addAttribute("name", name);
    	return "display.jsp";
    }
    
    @RequestMapping("/tasks/{id}")
    public String show(@Valid @PathVariable("id") Long id, @ModelAttribute("tasks") Task task, BindingResult result, HttpSession session, Model model) {
    	if(session.getAttribute("userId") == null) {
    		return "redirect:/";
    	}
//    	List<User> assignees = tServ.allUsers();
//		model.addAttribute("assignees", assignees);
//		System.out.println(assignees);
//    	List<User> x = tServ.allUsers();
//    	model.addAttribute("assigneeList", tServ.allUsers());
//    	System.out.println(x);
    	task = tServ.findTask(id);
    	model.addAttribute("tasks", task);
    	
    	return "show.jsp";
    }
    @PostMapping("/add_task")
    public String addTask(@Valid @ModelAttribute("tasks") Task task, BindingResult result, HttpSession session, Model model) {
    	
    	if(result.hasErrors()) {
    		List<User> x = tServ.allUsers();
        	model.addAttribute("assigneeList", tServ.allUsers());
    		return "new.jsp";
    	} else {
    		Long u = (Long) session.getAttribute("userId");
        	User name = tServ.findUserById(u);
    		System.out.println(u);
    		task.setCreator(name);
    		tServ.addTask(task);
    		return "redirect:/tasks";
    	}
    }
    @RequestMapping("/tasks/new")
    public String newTask(@ModelAttribute("tasks") Task task, BindingResult result, HttpSession session, Model model) {
    	if(session.getAttribute("userId") == null) {
    		return "redirect:/";
    	}
    	List<User> x = tServ.allUsers();
    	model.addAttribute("assigneeList", tServ.allUsers());
    	System.out.println(x);
    	return "new.jsp";
    }
    @RequestMapping("/completed/{id}")
    public String complete(@PathVariable("id") Long id) {
    	
    	tServ.deleteTask(id);
        return "redirect:/tasks";
    }
    @RequestMapping("/tasks/{id}/edit")
    public String ePage(@PathVariable("id") Long id, @ModelAttribute("tasks") Task task, BindingResult result, HttpSession session, Model model) {
    	if(session.getAttribute("userId") == null) {
    		return "redirect:/";
    	}
    	task = tServ.findTask(id);
    	model.addAttribute("tasks", task);
    	List<User> x = tServ.allUsers();
    	model.addAttribute("assigneeList", tServ.allUsers());
    	return "edit.jsp";
    }
    @PostMapping("/edit_task/{t_id}")
    public String update(@Valid @PathVariable("t_id") Long id, @ModelAttribute("tasks") Task tasks, BindingResult result, HttpSession session, Model model) {
    	if(tasks.getTask() == "") {
    		tasks = tServ.findTask(id);
        	model.addAttribute("tasks", tasks);
    		List<User> x = tServ.allUsers();
        	model.addAttribute("assigneeList", tServ.allUsers());
    		return "edit.jsp";
    	} else {
    	
    	Long tid = id;
    	String task = tasks.getTask();
    	User assignee = tasks.getAssignee();
    	String priority = tasks.getPriority();
    	
    	tServ.update(tid, task, assignee, priority);
    	return "redirect:/tasks/"+ id;
    	}
    }
    
}
