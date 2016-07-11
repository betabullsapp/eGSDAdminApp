package egsd.model;

import org.springframework.stereotype.Component;

@Component
public class EgsdLogin {

	private String username;
	private String password;
	private String user;
	public EgsdLogin() {
		super();
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	@Override
	public String toString() {
		return "EgsdLogin [username=" + username + ", password=" + password + ", user=" + user + "]";
	}
	
	
	
}
