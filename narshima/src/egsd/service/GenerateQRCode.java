package egsd.service;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.Hashtable;

import javax.imageio.ImageIO;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

public class GenerateQRCode {

 /**
  * @param args
  * @throws WriterException
  * @throws IOException
  */
 public byte[] qrCode(String id) throws WriterException, IOException {
  String qrCodeText = "http://betabullsapp.github.io/eGSD/directories.html?id="+id;
  
  int size = 125;
  String fileType = "jpg";
  
  byte[] byteArray = createQRImage(qrCodeText, size, fileType);
  System.out.println("DONE");
return byteArray;
 }

 private byte[] createQRImage(String qrCodeText, int size,
   String fileType) throws WriterException, IOException {
  // Create the ByteMatrix for the QR-Code that encodes the given String
  Hashtable hintMap = new Hashtable();
  ByteArrayOutputStream baos = new ByteArrayOutputStream();
  hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
  QRCodeWriter qrCodeWriter = new QRCodeWriter();
  System.out.println(qrCodeText);
  BitMatrix byteMatrix = qrCodeWriter.encode(qrCodeText,
    BarcodeFormat.QR_CODE, size, size, hintMap);
  // Make the BufferedImage that are to hold the QRCode
  int matrixWidth = byteMatrix.getWidth();
  BufferedImage image = new BufferedImage(matrixWidth, matrixWidth,
    BufferedImage.TYPE_INT_RGB);
  image.createGraphics();

  Graphics2D graphics = (Graphics2D) image.getGraphics();
  graphics.setColor(Color.WHITE);
  graphics.fillRect(0, 0, matrixWidth, matrixWidth);
  // Paint and save the image using the ByteMatrix
  graphics.setColor(Color.BLACK);

  for (int i = 0; i < matrixWidth; i++) {
   for (int j = 0; j < matrixWidth; j++) {
    if (byteMatrix.get(i, j)) {
     graphics.fillRect(i, j, 1, 1);
    }
   }
  }
  ImageIO.write(image, fileType, baos);
  baos.flush();
	byte[] imageInByte = baos.toByteArray();
	baos.close();
	return imageInByte;

 }

}