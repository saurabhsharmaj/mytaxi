package com.websystique.springmvc.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.websystique.springmvc.common.ListUtil;
import com.websystique.springmvc.common.TaxiConstants;
import com.websystique.springmvc.model.User;

@Service("userService")
@Transactional
public class UserServiceImpl implements UserService{
	
	private static final AtomicLong counter = new AtomicLong();
	
	private static List<User> users;
	
	static{
		users= populateDummyUsers();
	}

	public List<User> findAllUsers() {
		return users;
	}
	
	public User findById(long id) {
		for(User user : users){
			if(user.getId() == id){
				return user;
			}
		}
		return null;
	}
	
	public User findByName(String name) {
		for(User user : users){
			if(user.getUsername().equalsIgnoreCase(name)){
				return user;
			}
		}
		return null;
	}
	
	public void saveUser(User user) {
		user.setId(counter.incrementAndGet());
		users.add(user);
	}

	public void updateUser(User user) {
		int index = users.indexOf(user);
		users.set(index, user);
	}

	public void deleteUserById(long id) {
		
		for (Iterator<User> iterator = users.iterator(); iterator.hasNext(); ) {
		    User user = iterator.next();
		    if (user.getId() == id) {
		        iterator.remove();
		    }
		}
	}

	public boolean isUserExist(User user) {
		return findByName(user.getUsername())!=null;
	}
	
	public void deleteAllUsers(){
		users.clear();
	}

	private static List<User> populateDummyUsers(){
		List<User> users = new ArrayList<User>();
		users.add(new User(counter.incrementAndGet(),"Ansh", "IN", "ansh@gmail.com"));
		users.add(new User(counter.incrementAndGet(),"Abhinav", "IN", "abhinav@abc.com"));
		users.add(new User(counter.incrementAndGet(),"Amit", "IN", "amit@abc.com"));
		users.add(new User(counter.incrementAndGet(),"Chirag", "IN", "chirag@abc.com"));
		users.add(new User(counter.incrementAndGet(),"Deepak", "IN", "deepak@abc.com"));
		users.add(new User(counter.incrementAndGet(),"Gopesh", "IN", "gopesh@abc.com"));
		users.add(new User(counter.incrementAndGet(),"Hemant", "IN", "hemanth@abc.com"));
		users.add(new User(counter.incrementAndGet(),"Irfan", "IN", "irfan@abc.com"));
		users.add(new User(counter.incrementAndGet(),"Jagdish", "IN", "jagdish@abc.com"));
		users.add(new User(counter.incrementAndGet(),"Manish", "IN", "manish@abc.com"));
		users.add(new User(counter.incrementAndGet(),"Neha", "IN", "neha@abc.com"));
		users.add(new User(counter.incrementAndGet(),"Shanker", "IN", "shanker@abc.com"));
		users.add(new User(counter.incrementAndGet(),"Tanu", "IN", "tanu@abc.com"));
		users.add(new User(counter.incrementAndGet(),"Varun", "IN", "varun@abc.com"));
		users.add(new User(counter.incrementAndGet(),"Vijay", "IN", "vijay@abc.com"));
		return users;
	}

	@Override
	public List<User> findAllUsers(Integer page) {			
		return  ListUtil.slice(users, (page -1 )* TaxiConstants.PageLimit, TaxiConstants.PageLimit);
	}

}
