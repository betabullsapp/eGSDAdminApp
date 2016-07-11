package egsd.model;

public class EgsdSearchTemplateObjects {
	
	private String templateName;
	private String templateId;
	public String getTemplateName() {
		return templateName;
	}
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	public String getTemplateId() {
		return templateId;
	}
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	@Override
	public String toString() {
		return "EgsdSearchTemplateObjects [templateName=" + templateName
				+ ", templateId=" + templateId + "]";
	}
	public EgsdSearchTemplateObjects(String templateName, String templateId) {
		super();
		this.templateName = templateName;
		this.templateId = templateId;
	}
	
	

}
