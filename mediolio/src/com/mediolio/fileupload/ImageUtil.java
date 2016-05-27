package com.mediolio.fileupload;

import java.awt.Container;
import java.awt.Graphics;
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

/* ***** 오지은 작성
 * ***** 
 * ***** 이미지 크롭에서 사용하는 기능 모음
 * ***** 대부분 구글링하여 참고
 * */
public class ImageUtil {

	//InputStream에 들어있는 파일을 특정 경로(path)에 특정 이름(fileName)으로 업로드하는 함수
	public static void fileUpload(InputStream is, String path, String fileName) throws IOException {

		OutputStream out = null;

		try {
			File realUploadDir = new File(path);
			if (!realUploadDir.exists()) { // 경로에 폴더가 존재하지 않으면 생성
				realUploadDir.mkdirs();
			}
			out = new FileOutputStream(path + "/" + fileName);
			FileCopyUtils.copy(is, out); // InputStream에서 온 파일을 outputStream으로 복사

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
	
	//multipartFile 형식의 이미지를 Image 형식으로 변환하여 리턴하는 함수
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
	
	//Image 형식의 이미지를 BufferedImage 형식으로 변환하여 리턴하는 함수
	//구글링하여 긁어온 부분
	public static BufferedImage toBufferedImage(Image img){
	    if (img instanceof BufferedImage){
	        return (BufferedImage) img;
	    }

	    BufferedImage bimage = new BufferedImage(img.getWidth(null), img.getHeight(null), BufferedImage.TYPE_INT_RGB);
	    
	    Graphics bg = bimage.getGraphics();
	    bg.drawImage(img, 0, 0, null);
	    bg.dispose();

	    return bimage;
	}
}