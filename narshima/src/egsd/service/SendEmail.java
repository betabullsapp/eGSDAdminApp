package egsd.service;

import com.sendgrid.SendGrid;
import com.sendgrid.SendGridException;

public class SendEmail {

	public String sendEmail(String fname, String email, String username, String password, String userType) {
		
		SendGrid sendgrid = new SendGrid("hanuman.kachwa", "HEY_RAM@87");

	    SendGrid.Email sendemail = new SendGrid.Email();
	    sendemail.addTo(email);
	    sendemail.setFrom("no-reply@egsdirectory.com");
	    sendemail.setSubject("eGSD Admin Registration");
	    sendemail.setHtml("<div style='font-family: Calibri,sans-serif;font-size:11pt;'>Hi "+fname+",<br/><br/>An account created for you as "+userType+" for eGSD admin application with the following credentials.<br/><br/><b>Username : "+username+"</b><br/><b>Password : "+password+"</b><br/><br/>Please change your password for the first time login.<br/><br/>Login to the following link: http://egsd.mobldir.com:8080/egsdAdminApp/<br/><br/>Thanks,<br/>eGSD Support Team</div>");
	    //sendemail.setText("Hi "+fname+",\n\nAn account created for you as "+userType+" with the for eGSD admin application with the username : "+username+" and\npassword : "+password+". Please change your password for the first time login.\n\nLogin to the following link: http://egsd.mobldir.com:8080/egsdAdminApp/\n\nThanks,\neGSD Support Team ");

	    try {
	      SendGrid.Response response = sendgrid.send(sendemail);
	      System.out.println(response.getMessage());
	      
	    }
	    catch (SendGridException e) {
	      System.err.println(e);
	     
	    }
		return "successfully sent";

	}

}
