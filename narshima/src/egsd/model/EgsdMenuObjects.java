package egsd.model;

public class EgsdMenuObjects {

	
	private String objectId;
	private String menuId;
	private String description;
	private String price;
	private String styleId;
	private int sequence;
	
	
	public int getSequence() {
		return sequence;
	}



	public void setSequence(int sequence) {
		this.sequence = sequence;
	}



	public EgsdMenuObjects() {
		super();
	}
	

	
	



	public String getStyleId() {
		return styleId;
	}



	public void setStyleId(String styleId) {
		this.styleId = styleId;
	}



	public String getObjectId() {
		return objectId;
	}
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}



	@Override
	public String toString() {
		return "EgsdMenuObjects [objectId=" + objectId + ", menuId=" + menuId
				+ ", description=" + description + ", price=" + price
				+ ", styleId=" + styleId + ", sequence=" + sequence + "]";
	}



	public EgsdMenuObjects(String objectId, String menuId, String description,
			String price, String styleId, int sequence) {
		super();
		this.objectId = objectId;
		this.menuId = menuId;
		this.description = description;
		this.price = price;
		this.styleId = styleId;
		this.sequence = sequence;
	}
	
	
	
	
	
}
