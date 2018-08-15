package com.jym.exam.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;


import com.jym.exam.models.Task;
import com.jym.exam.models.User;
import com.jym.exam.repositories.TaskRepository;
import com.jym.exam.repositories.UserRepository;

@Service
public class TaskService {
	private final UserRepository uRepo;
	private final TaskRepository tRepo;
	
	public TaskService(UserRepository uRepo, TaskRepository tRepo) {
		this.uRepo = uRepo;
		this.tRepo = tRepo;
	}
	
	public List<Task> allTasks(){
		return tRepo.findAll();
	}
	public List<User> allUsers(){
		return uRepo.findAll();
	}
	public Task addTask(Task task) {
		return tRepo.save(task);
	}
	public User addUser(User user) {
		return uRepo.save(user);
	}
	public Task findTask(Long id) {
		Optional<Task> optionalTask = tRepo.findById(id);
		if(optionalTask.isPresent()) {
			return optionalTask.get();
		}else {
			return null;
		}
	}
	 public User registerUser(User user) {
	        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
	        user.setPassword(hashed);
	        return uRepo.save(user);
	    }
	    
	    // find user by email
	    public User findByEmail(String email) {
	        return uRepo.findByEmail(email);
	    }
	    
	    // find user by id
	    public User findUserById(Long id) {
	    	Optional<User> u = uRepo.findById(id);
	    	
	    	if(u.isPresent()) {
	            return u.get();
	    	} else {
	    	    return null;
	    	}
	    }
	    
	    // authenticate user
	    public boolean authenticateUser(String email, String password) {
	        // first find the user by email
	        User user = uRepo.findByEmail(email);
	        // if we can't find it by email, return false
	        if(user == null) {
	            return false;
	        } else {
	            // if the passwords match, return true, else, return false
	            if(BCrypt.checkpw(password, user.getPassword())) {
	                return true;
	            } else {
	                return false;
	            }
	        }
	    }
	    public Task update(Long tid, String task, User assignee, String priority) {
			Task tasks = findTask(tid);
		
			tasks.setTask(task);
			tasks.setAssignee(assignee);
			tasks.setPriority(priority);
			return tRepo.save(tasks);
			
		}
		public void deleteTask(Long id) {
			tRepo.deleteById(id);;
			
		}

		
}
