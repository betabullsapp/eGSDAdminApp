package egsd.model;

public class EgsdPhonesObjects {
	
	private String objectId;
	private String phoneId;
	private String type;
	private String ext;
	public EgsdPhonesObjects() {
		super();
	}
	public EgsdPhonesObjects(String objectId, String phoneId, String type, String ext) {
		super();
		this.objectId = objectId;
		this.phoneId = phoneId;
		this.type = type;
		this.ext = ext;
	}
	public String getObjectId() {
		return objectId;
	}
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}
	public String getPhoneId() {
		return phoneId;
	}
	public void setPhoneId(String phoneId) {
		this.phoneId = phoneId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getExt() {
		return ext;
	}
	public void setExt(String ext) {
		this.ext = ext;
	}
	
	

}
