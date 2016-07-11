package egsd.model;

public class DirectoryDetails {
	
	private String objectId;
	private String directoryId;
	private String styleId;
	private String locationId;
	public String getObjectId() {
		return objectId;
	}
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}
	public String getDirectoryId() {
		return directoryId;
	}
	public void setDirectoryId(String directoryId) {
		this.directoryId = directoryId;
	}
	public String getStyleId() {
		return styleId;
	}
	public void setStyleId(String styleId) {
		this.styleId = styleId;
	}
	public String getLocationId() {
		return locationId;
	}
	public void setLocationId(String locationId) {
		this.locationId = locationId;
	}
	@Override
	public String toString() {
		return "DirectoryDetails [objectId=" + objectId + ", directoryId="
				+ directoryId + ", styleId=" + styleId + ", locationId="
				+ locationId + ", getObjectId()=" + getObjectId()
				+ ", getDirectoryId()=" + getDirectoryId() + ", getStyleId()="
				+ getStyleId() + ", getLocationId()=" + getLocationId()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
	public DirectoryDetails(String objectId, String directoryId,
			String styleId, String locationId) {
		super();
		this.objectId = objectId;
		this.directoryId = directoryId;
		this.styleId = styleId;
		this.locationId = locationId;
	}
	
	

}
