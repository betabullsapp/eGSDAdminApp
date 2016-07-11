package egsd.model;

public class EgsdTemplateObjects {

	
	private String objectId;
	private String name;
	private String locationId;
	private boolean customized;
	private String templateFooter;
	private String templateImage;
	private String templateLogo;
	
	public String getTemplateFooter() {
		return templateFooter;
	}
	public void setTemplateFooter(String templateFooter) {
		this.templateFooter = templateFooter;
	}
	public String getTemplateImage() {
		return templateImage;
	}
	public void setTemplateImage(String templateImage) {
		this.templateImage = templateImage;
	}
	public String getTemplateLogo() {
		return templateLogo;
	}
	public void setTemplateLogo(String templateLogo) {
		this.templateLogo = templateLogo;
	}
	public EgsdTemplateObjects(String objectId, String name, String locationId, boolean customized) {
		super();
		this.objectId = objectId;
		this.name = name;
		this.locationId = locationId;
		this.customized = customized;
	}
	public String getObjectId() {
		return objectId;
	}
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLocationId() {
		return locationId;
	}
	public void setLocationId(String locationId) {
		this.locationId = locationId;
	}
	public boolean isCustomized() {
		return customized;
	}
	public void setCustomized(boolean customized) {
		this.customized = customized;
	}
	@Override
	public String toString() {
		return "EgsdTemplateObjects [objectId=" + objectId + ", name=" + name + ", locationId=" + locationId
				+ ", customized=" + customized + "]";
	}
		
	public EgsdTemplateObjects()  {}
	
	private String templateBrandBackgroundColor;
	private String templateFooterText;
	private String templateFooterImageBackgroundColor;
	private String templateFooterTextColor;
	private String templateFooterFont;
	private String templateFooterFontFamily;
	public String getTemplateBrandBackgroundColor() {
		return templateBrandBackgroundColor;
	}
	public void setTemplateBrandBackgroundColor(String templateBrandBackgroundColor) {
		this.templateBrandBackgroundColor = templateBrandBackgroundColor;
	}
	public String getTemplateFooterText() {
		return templateFooterText;
	}
	public void setTemplateFooterText(String templateFooterText) {
		this.templateFooterText = templateFooterText;
	}
	public String getTemplateFooterImageBackgroundColor() {
		return templateFooterImageBackgroundColor;
	}
	public void setTemplateFooterImageBackgroundColor(
			String templateFooterImageBackgroundColor) {
		this.templateFooterImageBackgroundColor = templateFooterImageBackgroundColor;
	}
	public String getTemplateFooterTextColor() {
		return templateFooterTextColor;
	}
	public void setTemplateFooterTextColor(String templateFooterTextColor) {
		this.templateFooterTextColor = templateFooterTextColor;
	}
	public String getTemplateFooterFont() {
		return templateFooterFont;
	}
	public void setTemplateFooterFont(String templateFooterFont) {
		this.templateFooterFont = templateFooterFont;
	}
	public String getTemplateFooterFontFamily() {
		return templateFooterFontFamily;
	}
	public void setTemplateFooterFontFamily(String templateFooterFontFamily) {
		this.templateFooterFontFamily = templateFooterFontFamily;
	}
	public String getStyleId() {
		return styleId;
	}
	public void setStyleId(String styleId) {
		this.styleId = styleId;
	}
	public String getTemplateColor() {
		return templateColor;
	}
	public void setTemplateColor(String templateColor) {
		this.templateColor = templateColor;
	}
	public String getTemplateFont() {
		return templateFont;
	}
	public void setTemplateFont(String templateFont) {
		this.templateFont = templateFont;
	}
	public String getTemplateFontFamily() {
		return templateFontFamily;
	}
	public void setTemplateFontFamily(String templateFontFamily) {
		this.templateFontFamily = templateFontFamily;
	}
	public String getTemplateCaption() {
		return templateCaption;
	}
	public void setTemplateCaption(String templateCaption) {
		this.templateCaption = templateCaption;
	}
	public String getTemplateCaptionColor() {
		return templateCaptionColor;
	}
	public void setTemplateCaptionColor(String templateCaptionColor) {
		this.templateCaptionColor = templateCaptionColor;
	}
	public String getTemplateCaptionFont() {
		return templateCaptionFont;
	}
	public void setTemplateCaptionFont(String templateCaptionFont) {
		this.templateCaptionFont = templateCaptionFont;
	}
	public String getTemplateCaptionFontFamily() {
		return templateCaptionFontFamily;
	}
	public void setTemplateCaptionFontFamily(String templateCaptionFontFamily) {
		this.templateCaptionFontFamily = templateCaptionFontFamily;
	}
	public String getTemplateBrandButtonColor() {
		return templateBrandButtonColor;
	}
	public void setTemplateBrandButtonColor(String templateBrandButtonColor) {
		this.templateBrandButtonColor = templateBrandButtonColor;
	}
	public String getTemplateBrandFontColor() {
		return templateBrandFontColor;
	}
	public void setTemplateBrandFontColor(String templateBrandFontColor) {
		this.templateBrandFontColor = templateBrandFontColor;
	}
	public String getTemplateBrandFontFamily() {
		return templateBrandFontFamily;
	}
	public void setTemplateBrandFontFamily(String templateBrandFontFamily) {
		this.templateBrandFontFamily = templateBrandFontFamily;
	}

	private String templateDescription;
	public String getTemplateDescription() {
		return templateDescription;
	}
	public void setTemplateDescription(String templateDescription) {
		this.templateDescription = templateDescription;
	}
	private String addressFont;
	public String getAddressFont() {
		return addressFont;
	}
	public void setAddressFont(String addressFont) {
		this.addressFont = addressFont;
	}

	private String addressColor;
	private String addressFontFamily;
	public String getAddressColor() {
		return addressColor;
	}
	public void setAddressColor(String addressColor) {
		this.addressColor = addressColor;
	}
	public String getAddressFontFamily() {
		return addressFontFamily;
	}
	public void setAddressFontFamily(String addressFontFamily) {
		this.addressFontFamily = addressFontFamily;
	}

	private String styleId;
	private String templateColor;
	private String templateFont;
	private String templateFontFamily;
	private String templateCaption;
	private String templateCaptionColor;
	private String templateCaptionFont;
	private String templateCaptionFontFamily;	
	private String templateBrandButtonColor;
	private String templateBrandFontColor;
	private String templateBrandFontFamily;
	private String templateTitleColor;
	private String templateTitleFont;
	private String templateTitleFamily;
	public String getTemplateTitleColor() {
		return templateTitleColor;
	}
	public void setTemplateTitleColor(String templateTitleColor) {
		this.templateTitleColor = templateTitleColor;
	}
	public String getTemplateTitleFont() {
		return templateTitleFont;
	}
	public void setTemplateTitleFont(String templateTitleFont) {
		this.templateTitleFont = templateTitleFont;
	}
	public String getTemplateTitleFamily() {
		return templateTitleFamily;
	}
	public void setTemplateTitleFamily(String templateTitleFamily) {
		this.templateTitleFamily = templateTitleFamily;
	}
	
	
	
}
