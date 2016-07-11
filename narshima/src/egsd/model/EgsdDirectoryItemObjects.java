package egsd.model;

import org.parse4j.ParseObject;

public class EgsdDirectoryItemObjects   {
	 
	private String objectId;
	private String directoryId;
	private String title;
	private String caption;
	private String description;
	private String timings;
	private String website;
	private String email;
	private String parentDirectoryId;
	private String picture;
    private String styleId;
    private String phones;
    private String parentReferrence;
    private String locationId;
	private String customizedOrder;
	public String getCustomizedOrder() {
		return customizedOrder;
	}
	public void setCustomizedOrder(String customizedOrder) {
		this.customizedOrder = customizedOrder;
	}
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCaption() {
		return caption;
	}
	public void setCaption(String caption) {
		this.caption = caption;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getTimings() {
		return timings;
	}
	public void setTimings(String timings) {
		this.timings = timings;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getParentDirectoryId() {
		return parentDirectoryId;
	}
	public void setParentDirectoryId(String parentDirectoryId) {
		this.parentDirectoryId = parentDirectoryId;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getStyleId() {
		return styleId;
	}
	public void setStyleId(String styleId) {
		this.styleId = styleId;
	}
	public String getPhones() {
		return phones;
	}
	public void setPhones(String phones) {
		this.phones = phones;
	}
	public String getParentReferrence() {
		return parentReferrence;
	}
	public void setParentReferrence(String parentReferrence) {
		this.parentReferrence = parentReferrence;
	}
	public String getLocationId() {
		return locationId;
	}
	public void setLocationId(String locationId) {
		this.locationId = locationId;
	}
	@Override
	public String toString() {
		return "EgsdDirectoryItemObjects [objectId=" + objectId
				+ ", directoryId=" + directoryId + ", title=" + title
				+ ", caption=" + caption + ", description=" + description
				+ ", timings=" + timings + ", website=" + website + ", email="
				+ email + ", parentDirectoryId=" + parentDirectoryId
				+ ", picture=" + picture + ", styleId=" + styleId + ", phones="
				+ phones + ", parentReferrence=" + parentReferrence
				+ ", locationId=" + locationId + ", customizedOrder="
				+ customizedOrder + "]";
	}
	public EgsdDirectoryItemObjects(String objectId, String directoryId,
			String title, String caption, String description, String timings,
			String website, String email, String parentDirectoryId,
			String picture, String styleId, String phones,
			String parentReferrence, String locationId, String customizedOrder) {
		super();
		this.objectId = objectId;
		this.directoryId = directoryId;
		this.title = title;
		this.caption = caption;
		this.description = description;
		this.timings = timings;
		this.website = website;
		this.email = email;
		this.parentDirectoryId = parentDirectoryId;
		this.picture = picture;
		this.styleId = styleId;
		this.phones = phones;
		this.parentReferrence = parentReferrence;
		this.locationId = locationId;
		this.customizedOrder = customizedOrder;
	}
	
    
    
		
}
