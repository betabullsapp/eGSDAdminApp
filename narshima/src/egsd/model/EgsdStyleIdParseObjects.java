package egsd.model;

import org.parse4j.ParseClassName;
import org.parse4j.ParseObject;
@ParseClassName("StyleID")
public class EgsdStyleIdParseObjects extends ParseObject{

	
	//TitleFont
		public String getTitleFont(){
			return  getString("TitleFont");
		}

		public void setTitleFont(String value) {
			put("TitleFont", value);
		}
	//StyleID
		public String getStyleID(){
			return  getString("StyleID");
		}

		public void setStyleID(String value) {
			put("StyleID", value);
		}
}
