package egsd.model;

import org.parse4j.ParseClassName;
import org.parse4j.ParseObject;
public class EgsdLoctionObject  {
	
	private String objectId;
	private String directory;
	private String locationAdmin;
	private String locFirstName;
	private String locLastName;
	public String getLocFirstName() {
		return locFirstName;
	}


	public void setLocFirstName(String locFirstName) {
		this.locFirstName = locFirstName;
	}


	public String getLocLastName() {
		return locLastName;
	}


	public void setLocLastName(String locLastName) {
		this.locLastName = locLastName;
	}
	private String locObjectId;
	public String getLocObjectId() {
		return locObjectId;
	}


	public void setLocObjectId(String locObjectId) {
		this.locObjectId = locObjectId;
	}


	public String getLocationAdmin() {
		return locationAdmin;
	}


	public void setLocationAdmin(String locationAdmin) {
		this.locationAdmin = locationAdmin;
	}
	private String name;
	private String zipcode;
	private String address;
	private String address2;
	private String street;
	private String town;
	private double longitude;
	private double latitude;
	public double getLongitude() {
		return longitude;
	}


	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}


	public double getLatitude() {
		return latitude;
	}


	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	private String siteId;
	private String groupName;
	private String logo;
	private String hotelLogo;
	private String footerLogo;
	public String getHotelLogo() {
		return hotelLogo;
	}


	public void setHotelLogo(String hotelLogo) {
		this.hotelLogo = hotelLogo;
	}


	public String getFooterLogo() {
		return footerLogo;
	}


	public void setFooterLogo(String footerLogo) {
		this.footerLogo = footerLogo;
	}
	private String qRCode;
	private String parentDirectoryId;
	private String description;
	private String addressColor;
	public String getLocationAddressFontFamily() {
		return locationAddressFontFamily;
	}


	public void setLocationAddressFontFamily(String locationAddressFontFamily) {
		this.locationAddressFontFamily = locationAddressFontFamily;
	}
	private String addressFont;
	private String brandBackgroundColor;
	private String footerText;
	private String footerImageBackgroundColor;
	private String footerTextColor;
	private String footerFont;
	private String footerFontFamily;
	private String styleId;
	private String hotelColor;
	private String hotelFont;
	private String hotelFontFamily;
	private String hotelCaption;
	private String captionColor;
	private String captionFont;
	private String captionFontFamily;
	private String locationAddressFontFamily;
	private String brandButtonColor;
	private String brandFontColor;
	private String brandFontFamily;
	
	
	
	
	

	 public String getBrandButtonColor(){
		   return brandButtonColor;
	   }
	   
	   public void setBrandButtonColor(String brandButtonColor){
		   this.brandButtonColor=brandButtonColor;
	   }
	   
	   public String getBrandFontColor(){
		   return brandFontColor;
	   }
	  
	   public void setBrandFontColor(String brandFontColor){
		   this.brandFontColor=brandFontColor;
	   }
	  
	   public String getBrandFontFamily(){
		   return brandFontFamily;
	   }
	   
	   public void setBrandFontFamily(String brandFontFamily){
		   this.brandFontFamily=brandFontFamily;
	   }
		
	
	public String getHotelColor() {
		return hotelColor;
	}


	public void setHotelColor(String hotelColor) {
		this.hotelColor = hotelColor;
	}


	public String getHotelFont() {
		return hotelFont;
	}


	public void setHotelFont(String hotelFont) {
		this.hotelFont = hotelFont;
	}


	public String getHotelFontFamily() {
		return hotelFontFamily;
	}


	public void setHotelFontFamily(String hotelFontFamily) {
		this.hotelFontFamily = hotelFontFamily;
	}


	public String getHotelCaption() {
		return hotelCaption;
	}


	public void setHotelCaption(String hotelCaption) {
		this.hotelCaption = hotelCaption;
	}


	public String getCaptionColor() {
		return captionColor;
	}


	public void setCaptionColor(String captionColor) {
		this.captionColor = captionColor;
	}


	public String getCaptionFont() {
		return captionFont;
	}


	public void setCaptionFont(String captionFont) {
		this.captionFont = captionFont;
	}


	public String getCaptionFontFamily() {
		return captionFontFamily;
	}


	public void setCaptionFontFamily(String captionFontFamily) {
		this.captionFontFamily = captionFontFamily;
	}


	


	public String getStyleId() {
		return styleId;
	}


	public void setStyleId(String styleId) {
		this.styleId = styleId;
	}


	public String getAddressColor() {
		return addressColor;
	}


	public void setAddressColor(String addressColor) {
		this.addressColor = addressColor;
	}


	public String getAddressFont() {
		return addressFont;
	}


	public void setAddressFont(String addressFont) {
		this.addressFont = addressFont;
	}


	public String getBrandBackgroundColor() {
		return brandBackgroundColor;
	}


	public void setBrandBackgroundColor(String brandBackgroundColor) {
		this.brandBackgroundColor = brandBackgroundColor;
	}


	public String getFooterText() {
		return footerText;
	}


	public void setFooterText(String footerText) {
		this.footerText = footerText;
	}


	public String getFooterImageBackgroundColor() {
		return footerImageBackgroundColor;
	}


	public void setFooterImageBackgroundColor(String footerImageBackgroundColor) {
		this.footerImageBackgroundColor = footerImageBackgroundColor;
	}


	public String getFooterTextColor() {
		return footerTextColor;
	}


	public void setFooterTextColor(String footerTextColor) {
		this.footerTextColor = footerTextColor;
	}


	public String getFooterFont() {
		return footerFont;
	}


	public void setFooterFont(String footerFont) {
		this.footerFont = footerFont;
	}


	public String getFooterFontFamily() {
		return footerFontFamily;
	}


	public void setFooterFontFamily(String footerFontFamily) {
		this.footerFontFamily = footerFontFamily;
	}


	

	
	public EgsdLoctionObject(String objectId, String directory, String name, String zipcode, String address,
			String address2, String street, String town, String siteId, String groupName, String logo, String qRCode,
			String parentDirectoryId, String description, String addressColor, String addressFont,
			String brandBackgroundColor, String footerText, String footerImageBackgroundColor, String footerTextColor,
			String footerFont, String footerFontFamily, String styleId, String country) {
		super();
		this.objectId = objectId;
		this.directory = directory;
		this.name = name;
		this.zipcode = zipcode;
		this.address = address;
		this.address2 = address2;
		this.street = street;
		this.town = town;
		this.siteId = siteId;
		this.groupName = groupName;
		this.logo = logo;
		this.qRCode = qRCode;
		this.parentDirectoryId = parentDirectoryId;
		this.description = description;
		this.addressColor = addressColor;
		this.addressFont = addressFont;
		this.brandBackgroundColor = brandBackgroundColor;
		this.footerText = footerText;
		this.footerImageBackgroundColor = footerImageBackgroundColor;
		this.footerTextColor = footerTextColor;
		this.footerFont = footerFont;
		this.footerFontFamily = footerFontFamily;
		this.styleId = styleId;
		this.country = country;
	}


	public EgsdLoctionObject()  {}
	
	public String getSiteId() {
		return siteId;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	private String country;
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}

	public String getObjectId() {
		return objectId;
	}
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}
	public String getDirectory() {
		return directory;
	}
	public void setDirectory(String directory) {
		this.directory = directory;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getTown() {
		return town;
	}
	public void setTown(String town) {
		this.town = town;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public String getqRCode() {
		return qRCode;
	}
	public void setqRCode(String qRCode) {
		this.qRCode = qRCode;
	}
	public String getParentDirectoryId() {
		return parentDirectoryId;
	}
	public void setParentDirectoryId(String parentDirectoryId) {
		this.parentDirectoryId = parentDirectoryId;
	}
	
	
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}


	@Override
	public String toString() {
		return "EgsdLoctionObject [objectId=" + objectId + ", directory=" + directory + ", name=" + name + ", zipcode="
				+ zipcode + ", address=" + address + ", address2=" + address2 + ", street=" + street + ", town=" + town
				+ ", siteId=" + siteId + ", groupName=" + groupName + ", logo=" + logo + ", qRCode=" + qRCode
				+ ", parentDirectoryId=" + parentDirectoryId + ", description=" + description + ", addressColor="
				+ addressColor + ", addressFont=" + addressFont + ", brandBackgroundColor=" + brandBackgroundColor
				+ ", footerText=" + footerText + ", footerImageBackgroundColor=" + footerImageBackgroundColor
				+ ", footerTextColor=" + footerTextColor + ", footerFont=" + footerFont + ", footerFontFamily="
				+ footerFontFamily + ", styleId=" + styleId + ", hotelColor=" + hotelColor + ", hotelFont=" + hotelFont
				+ ", hotelFontFamily=" + hotelFontFamily + ", hotelCaption=" + hotelCaption + ", captionColor="
				+ captionColor + ", captionFont=" + captionFont + ", captionFontFamily=" + captionFontFamily
				+ ", addressFontFamily=" + locationAddressFontFamily + ", country=" + country + "]";
	}


	

	
	
	
}
