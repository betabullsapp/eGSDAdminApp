package egsd.model;

import org.parse4j.ParseClassName;
import org.parse4j.ParseFile;
import org.parse4j.ParseObject;

@ParseClassName("Phones")
public class EgsdPhonesParseObject extends ParseObject {

	// phoneId
	public String getPhoneId() {
		return getString("PhoneId");
	}

	public void setPhoneId(String value) {
		put("PhoneId", value);
	}

	// Type
	public String getType() {
		return getString("Type");
	}

	public void setType(String value) {
		put("Type", value);
	}

	// Ext
	public String getExt() {
		return getString("Ext");
	}

	public void setExt(String value) {
		put("Ext", value);
	}

}
