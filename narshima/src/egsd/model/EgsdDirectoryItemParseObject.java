package egsd.model;

import org.parse4j.ParseClassName;
import org.parse4j.ParseFile;
import org.parse4j.ParseObject;

@ParseClassName("DirectoryItem")
public class EgsdDirectoryItemParseObject extends ParseObject {

	//location id
		public String getLocationId(){
			return  getString("LocationId");
		}

		public void setLocationId(String value) {
			put("LocationId", value);
		}

	
	//ParentDirectoryId
	public String getParentDirectoryId(){
		return  getString("ParentDirectoryId");
	}

	public void setParentDirectoryId(String value) {
		put("ParentDirectoryId", value);
	}
	
	//DirectoryID
	public String getDirectoryId() {
		return getString("DirectoryID");
	}

	public void setDisplayName(String value) {
		put("DirectoryID", value);
	}
	
	//Title
	public String getTitle() {
		return getString("Title");
	}

	public void setTitle(String value) {
		put("Title", value);
	}
	//Caption
	public String getCaption() {
		return getString("Caption");
	}

	public void setCaption(String value) {
		put("Caption", value);
	}
	
	//Description
	public String getDescription() {
		return getString("Description");
	}

	public void setDescription(String value) {
		put("Description", value);
	}
	
	//Timings
	public String getTimings() {
		return getString("Timings");
	}

	public void setTimings(String value) {
		put("Timings", value);
	}
	
	//Website
	public String getWebsite() {
		return getString("Website");
	}

	public void setWebsite(String value) {
		put("Website", value);
	}
	
	//DirectoryID
	public String getCustomizedOrder() {
		return getString("CustomizedOrder");
	}

	public void setCustomizedOrder(String value) {
		put("CustomizedOrder", value);
	}
	
	//Email
	public String getEmail() {
		return getString("Email");
	}

	public void setEmail(String value) {
		put("Email", value);
	}
	
	//Phones
	public String getPhones() {
		return getString("Phones");
	}

	public void setPhones(String value) {
		put("Phones", value);
	}
	
	//pictures
	public ParseFile getPicture() {
		return getParseFile("Picture");
	}

	public void setPicture(String value) {
		put("Picture", value);
	}
	
	//styleId
	public ParseObject getStyleID() {
		return getParseObject("StyleID");
	}

	public void setStyleID(ParseObject value) {
		put("StyleID", value);
	}
	
}
