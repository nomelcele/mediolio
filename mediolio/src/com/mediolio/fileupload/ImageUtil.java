package com.mediolio.fileupload;
import java.awt.Container;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.MediaTracker;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;


public class ImageUtil {

	public static void fileUpload(InputStream is, String path, String fileName) throws IOException {

		//String originalFileName = fileData.getOriginalFilename();
		//String contentType = fileData.getContentType();
		//long fileSize = fileData.getSize();

		/*
		 * System.out.println("file Info"); System.out.println("fileName " +
		 * fileName); System.out.println("originalFileName :" +
		 * originalFileName); System.out.println("contentType :" + contentType);
		 * System.out.println("fileSize :" + fileSize);
		 */

		OutputStream out = null;

		try {
			File realUploadDir = new File(path);
			if (!realUploadDir.exists()) { // 경로에 폴더가 존재하지 않으면 생성합니다.
				realUploadDir.mkdirs();
			}
			out = new FileOutputStream(path + "/" + fileName);
			FileCopyUtils.copy(is, out); // InputStream에서 온 파일을
											// outputStream으로 복사

		} catch (IOException e) {
			e.printStackTrace();
			new IOException("파일 업로드에 실패하였습니다.");
		} finally {
			if (out != null) {
				out.close();
			}
			if (is != null) {
				is.close();
			}
		}
	}
	public static Image get_imageObj(MultipartFile mf){
		Toolkit toolKit = Toolkit.getDefaultToolkit();
		MediaTracker mtracker = new MediaTracker(new Container());
		Image image = null;
		try {
			image = toolKit.createImage(mf.getBytes());
			mtracker.addImage(image, 1);
			mtracker.waitForID(1);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return image;
	}
	
	public static BufferedImage toBufferedImage(Image img){
	    if (img instanceof BufferedImage)
	    {
	        return (BufferedImage) img;
	    }

	    // Create a buffered image with transparency
	    BufferedImage bimage = new BufferedImage(img.getWidth(null), img.getHeight(null), BufferedImage.TYPE_INT_RGB);
	    
	    Graphics bg = bimage.getGraphics();
	    bg.drawImage(img, 0, 0, null);
	    bg.dispose();

	    // Return the buffered image
	    return bimage;
	}
}