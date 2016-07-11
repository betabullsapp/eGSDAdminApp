package egsd.model;

import org.parse4j.ParseClassName;
import org.parse4j.ParseObject;
@ParseClassName("Menu")
public class EgsdMenuParseObjects extends ParseObject {
	
	public String getMenuId(){
		return  getString("MenuId");
	}
	
	public void setMenuId(String value) {
		put("MenuId", value);
	}
	
	public String getDescription(){
		return  getString("Description");
	}

	public void setDescription(String value) {
		put("Description", value);
	}
	
	public String getPrice(){
		return  getString("Price");
	}
	
	public void setPrice(String value) {
		put("Price", value);
	}

	public ParseObject getStyleID(){
		return  getParseObject("StyleID");
	}
	
	public void setStyleID(ParseObject value) {
		put("StyleID", value);
	}
	
	public String getobjectId(){
		return  getString("objectId");
	}

	
	
	

}
