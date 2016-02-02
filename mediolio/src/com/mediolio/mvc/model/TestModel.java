package com.mediolio.mvc.model;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.fileupload.ImageUtil;
import com.mediolio.vo.MessageVO;

@Controller
public class TestModel {

	@RequestMapping("gotoTest")
	public ModelAndView gotoTest(){
		return new ModelAndView("test");
	}
	
	@RequestMapping(value = "imgCrop_modal")
	public String imgCrop_modal(Model model, @RequestParam("url") String url) throws IOException{
		model.addAttribute("imgUrl", url);
		return "cropModal";
		
	}
	
	@RequestMapping(value = "cropImage", method = RequestMethod.POST)
	public ModelAndView cropImage( MultipartHttpServletRequest  request, HttpServletResponse response, HttpSession session) throws IOException{
		ModelAndView mav = new ModelAndView("jsonView");
		
		MultipartFile multipartFile = request.getFile("coverImg");
		String fileFullName = multipartFile.getOriginalFilename();
		String fileName = fileFullName.substring(0, fileFullName.lastIndexOf("."));
		String fileType = fileFullName.substring(fileFullName.lastIndexOf(".")+1, fileFullName.length());
		System.out.println("fileName : " + fileName + ", " + "fileType : " + fileType);
		
		//경로
		String saveDir = new HttpServletRequestWrapper(request).getSession().getServletContext().getRealPath("/resources/images/projectCover");
		System.out.println(saveDir);
		
		int x=(int) Float.parseFloat(request.getParameter("x"));
        int y=(int) Float.parseFloat(request.getParameter("y"));
        int w=(int) Float.parseFloat(request.getParameter("w"))-4;
        int h=(int) Float.parseFloat(request.getParameter("h"))-4;
        System.out.println(x+" "+y+" "+w+" "+h);

		try {
			//multipartFile->Image->BufferedImage
			Image originalImage = ImageUtil.get_imageObj(multipartFile);
			BufferedImage buffered_originalImg = ImageUtil.toBufferedImage(originalImage);
			
			//crop 이미지 생성 과정
			BufferedImage SubImage = buffered_originalImg.getSubimage(x, y, w, h);
			System.out.println("Cropped image dimension: "+SubImage.getWidth()+"x"+SubImage.getHeight());
			
			//이름 재설정
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
			String cropReplaceName = "crop_"+fileName+"_"+formatter.format(new Date()) +"."+ fileType;
			
			//bufferedImage -> InputStream
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ImageIO.write(SubImage, fileType, baos);
			InputStream is = new ByteArrayInputStream(baos.toByteArray());
			
			//파일쓰기
			ImageUtil.fileUpload(is, saveDir, cropReplaceName);
			
			mav.addObject("result", cropReplaceName);
		} catch (IOException e) {
			e.printStackTrace();
			mav.addObject("result", "fail");
		}	
		return mav;
	}

	
}
