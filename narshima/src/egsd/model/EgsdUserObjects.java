package egsd.model;

public class EgsdUserObjects {

	private String objectId;
	private String username;
	private String password;
	private String firstname;
	private String lastname;
	private String phone;
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	private String email;
	private String user;
	private String locationId;
	public EgsdUserObjects(String objectId, String username, String password, String email, String user, String locationId, 
			String firstname, String lastname,String phone) {
		super();
		this.objectId = objectId;
		this.username = username;
		this.password = password;
		this.email = email;
		this.user = user;		
		this.locationId = locationId;
		this.firstname = firstname;
		this.lastname = lastname;
		this.phone = phone;
	}
	public EgsdUserObjects() {
		// TODO Auto-generated constructor stub
	}
	public String getObjectId() {
		return objectId;
	}
	public void setObjectId(String objectId) {
		this.objectId = objectId;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getLocationId() {
		return locationId;
	}
	public void setLocationId(String locationId) {
		this.locationId = locationId;
	}
	@Override
	public String toString() {
		return "EgsdUserObjects [objectId=" + objectId + ", username="
				+ username + ", password=" + password + ", firstname="
				+ firstname + ", lastname=" + lastname + ", phone=" + phone +", email=" + email
				+ ", user=" + user + ", locationId=" + locationId + "]";
	}
	
	
	
	
	
}
