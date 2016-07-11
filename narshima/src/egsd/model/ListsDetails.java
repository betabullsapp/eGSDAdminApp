package egsd.model;

import java.util.List;

public class ListsDetails {
	
	List<EgsdLoctionObject> locationObjects;
	List<EgsdDirectoryItemObjects> directoryObjects;
	List<EgsdPhonesObjects> phonesObjects;
	List<EgsdMenuObjects> menuObjects;
	List<EgsdStyleObjects> styleObjects;
	
	public List<EgsdLoctionObject> getLocationObjects() {
		return locationObjects;
	}
	public void setLocationObjects(List<EgsdLoctionObject> locationObjects) {
		this.locationObjects = locationObjects;
	}
	public List<EgsdDirectoryItemObjects> getDirectoryObjects() {
		return directoryObjects;
	}
	public void setDirectoryObjects(List<EgsdDirectoryItemObjects> directoryObjects) {
		this.directoryObjects = directoryObjects;
	}
	public List<EgsdPhonesObjects> getPhonesObjects() {
		return phonesObjects;
	}
	public void setPhonesObjects(List<EgsdPhonesObjects> phonesObjects) {
		this.phonesObjects = phonesObjects;
	}
	public List<EgsdMenuObjects> getMenuObjects() {
		return menuObjects;
	}
	public void setMenuObjects(List<EgsdMenuObjects> menuObjects) {
		this.menuObjects = menuObjects;
	}
	public List<EgsdStyleObjects> getStyleObjects() {
		return styleObjects;
	}
	public void setStyleObjects(List<EgsdStyleObjects> styleObjects) {
		this.styleObjects = styleObjects;
	}

}
