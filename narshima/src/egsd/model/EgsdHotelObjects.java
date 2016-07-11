package egsd.model;

public class EgsdHotelObjects {
	
	private String name;
	private String hotelId;
	private String groupId;
	private String zipcode;
	private String groupName;
	private String email;
	private String adminName;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getHotelId() {
		return hotelId;
	}
	public void setHotelId(String hotelId) {
		this.hotelId = hotelId;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	@Override
	public String toString() {
		return "EgsdHotelObjects [name=" + name + ", hotelId=" + hotelId
				+ ", groupId=" + groupId + ", zipcode=" + zipcode
				+ ", groupName=" + groupName + "]";
	}
	public EgsdHotelObjects(String name, String hotelId, String groupId,
			String zipcode, String groupName) {
		super();
		this.name = name;
		this.hotelId = hotelId;
		this.groupId = groupId;
		this.zipcode = zipcode;
		this.groupName = groupName;
	}
	
	public EgsdHotelObjects(){}
	
	
	

}
