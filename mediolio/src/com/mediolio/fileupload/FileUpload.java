package com.mediolio.fileupload;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class FileUpload {

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
}