package com.mediolio.mvc.model;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.fileupload.FileUpload;

@Controller
public class TestModel {

	@RequestMapping("gotoTest")
	public ModelAndView gotoTest(){
		return new ModelAndView("test");
	}
	
	@RequestMapping(value = "imgCrop_modal", method = RequestMethod.POST)
	public String imgCrop_modal(Model model, MultipartHttpServletRequest  multipartRequest) throws IOException{
		//원본이미지파일
		MultipartFile multipartFile = multipartRequest.getFile("p_coverImg");   //뷰에서 form으로 넘어올 때 name에 적어준 이름
		//이미지 미리보기 경로
		String url = multipartRequest.getParameter("preview_url");
		
		//원본이미지 이름
		String fileName = multipartFile.getOriginalFilename();

        //String contentType = multipartFile.getContentType();
        //InputStream stream = multipartFile.getInputStream();
        //byte[] bytes = IOUtils.toByteArray(stream);
		//String src = "data:"+contentType+";base64,"+new String(Base64Utils.encode(bytes));
        
		model.addAttribute("imgObj", multipartFile); 
        model.addAttribute("imgUrl", url);
        System.out.println("fileName : " + fileName + ", url : " + url);
		return "cropModal";
		
	}
	
	@RequestMapping(value = "cropImage", method = RequestMethod.POST)
	public ModelAndView cropImage( MultipartHttpServletRequest  request, HttpServletResponse response, HttpSession session) throws IOException{
		ModelAndView mav = new ModelAndView("jsonView");
		
		MultipartFile multipartFile = request.getFile("p_coverImg");
		String fileFullName = multipartFile.getOriginalFilename();
		String fileName = fileFullName.substring(0, fileFullName.lastIndexOf("."));
		String fileType = fileFullName.substring(fileFullName.lastIndexOf(".")+1, fileFullName.length());
		System.out.println("fileName : " + fileName + ", " + "fileType : " + fileType);
		
		//경로
		String saveDir = new HttpServletRequestWrapper(request).getSession().getServletContext().getRealPath("/resources/projectCover");
		
		//대체이름
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		Date nowdate = new Date();
		String originReplaceName = fileName+"_"+formatter.format(nowdate) +"."+ fileType;
		FileUpload.fileUpload(multipartFile.getInputStream(), saveDir+"/OriginFile", originReplaceName);
		
		int x=(int) Float.parseFloat(request.getParameter("x"));
        int y=(int) Float.parseFloat(request.getParameter("y"));
        int w=(int) Float.parseFloat(request.getParameter("w"))-4;
        int h=(int) Float.parseFloat(request.getParameter("h"))-4;
        System.out.println(x+" "+y+" "+w+" "+h);
        
        System.out.println(saveDir);
        
		try {
			BufferedImage originalImage = ImageIO.read(new File(saveDir+"/OriginFile/"+originReplaceName));
			System.out.println("Original image dimension: "+originalImage.getWidth()+"x"+originalImage.getHeight());
			BufferedImage SubImage = originalImage.getSubimage(x, y, w, h);
			System.out.println("Cropped image dimension: "+SubImage.getWidth()+"x"+SubImage.getHeight());
			
			String cropReplaceName = "crop_"+originReplaceName;
			
			//bufferedImage -> InputStream
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ImageIO.write(SubImage, fileType, baos);
			InputStream is = new ByteArrayInputStream(baos.toByteArray());
			
			//파일쓰기
			FileUpload.fileUpload(is, saveDir, cropReplaceName);
			
			mav.addObject("result", cropReplaceName);
		} catch (IOException e) {
			e.printStackTrace();
			mav.addObject("result", "fail");
		}
		
		return mav;
	}
}
