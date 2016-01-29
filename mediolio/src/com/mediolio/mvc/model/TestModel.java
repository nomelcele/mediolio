package com.mediolio.mvc.model;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TestModel {

	@RequestMapping("gotoTest")
	public ModelAndView gotoTest(){
		return new ModelAndView("tutorial3");
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
