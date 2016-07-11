package egsd.service;
import java.awt.print.PrinterAbortException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

import javax.print.CancelablePrintJob;
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.standard.Copies;

public class PrintImage {
  public String printImage(String imgUrl) throws Exception {
	
	  
	  try{
		    PrintRequestAttributeSet pras = new HashPrintRequestAttributeSet();
		    pras.add(new Copies(1));

		    PrintService pss[] = PrintServiceLookup.lookupPrintServices(DocFlavor.INPUT_STREAM.JPEG, pras);

		    PrintService ps = pss[0];
		    System.out.println("Printing to " + ps);

		    DocPrintJob job = ps.createPrintJob();
		    //URL url = new URL("http://files.parsetfss.com/fd010cff-584f-4a10-830d-462c0c23f7d0/tfss-bfd5cc01-3a82-4a42-8177-06c80240076d-logo.jpg");
		    URL url = new URL(imgUrl);
		    URLConnection conn = url.openConnection();
		    InputStream is = conn.getInputStream();
		    //FileInputStream  = new FileInputStream("D:/practies/img.jpg");
		    Doc doc = new SimpleDoc(is, DocFlavor.INPUT_STREAM.JPEG, null);
		    
		    //PrintJobWatcher pjDone = new PrintJobWatcher(job);

		    if (job instanceof CancelablePrintJob) {
		      CancelablePrintJob cancelJob = (CancelablePrintJob) job;
		      try {
		        cancelJob.cancel();
		      } catch (PrintException e) {
		      }
		    }
		    
		    job.print(doc, pras);
		    //pjDone.waitForDone();
		    is.close();
			  } catch(PrintException e)
			  {
				  if (e.getCause() instanceof PrinterAbortException) {
				        System.out.println("Print job was cancelled"); 
				      }
			  }
	  
	  return "success";
    
	
	
  }
}