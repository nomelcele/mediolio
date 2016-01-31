package com.mediolio.mvc.model;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

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
		//String src = "data:'"+contentType+"';base64,'"+new String(Base64Utils.encode(bytes))+"'";
        
		model.addAttribute("imgObj", multipartFile); 
        model.addAttribute("imgUrl", url);
        System.out.println("fileName : " + fileName + ", url : " + url);
		return "cropModal";
		
	}
	
	@RequestMapping("cropImage")
	public String cropImage(HttpServletRequest request,HttpServletResponse response,
            HttpSession session) throws IOException{
        int x=Integer.parseInt(request.getParameter("x"));
        int y=Integer.parseInt(request.getParameter("y"));
        int w=Integer.parseInt(request.getParameter("w"));
        int h=Integer.parseInt(request.getParameter("h"));
        System.out.println(x+" "+y+" "+" "+w+" "+" "+h);

		String absolutePath = "C:/Users/JieunO/Desktop/original-crop/";
		try {
			BufferedImage originalImgage = ImageIO.read(new File(absolutePath+"pool.jpg"));
			System.out.println("Original image dimension: "+originalImgage.getWidth()+"x"+originalImgage.getHeight());
			BufferedImage SubImgage = originalImgage.getSubimage(x, y, w, h);
			System.out.println("Cropped image dimension: "+SubImgage.getWidth()+"x"+SubImgage.getHeight());
			File outputfile = new File(absolutePath + "croppedImage.jpg");
			ImageIO.write(SubImgage, "jpg", outputfile);
			
			System.out.println("Image cropped successfully: "+outputfile.getPath());
			
			return outputfile.getName();
		} catch (IOException e) {
			e.printStackTrace();
			return "";
		}

       //return "redirect:/tutorial3";
	}
}
