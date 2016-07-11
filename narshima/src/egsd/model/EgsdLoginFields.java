package egsd.model;

import org.parse4j.ParseClassName;
import org.parse4j.ParseObject;
@ParseClassName("User")
public class EgsdLoginFields extends ParseObject {
	
	private String username;
	private String password;
	private String user;
	
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public EgsdLoginFields() {
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
	@Override
	public String toString() {
		return "EgsdLoginFields [username=" + username + ", password=" + password + ", user=" + user + "]";
	}
	
}
