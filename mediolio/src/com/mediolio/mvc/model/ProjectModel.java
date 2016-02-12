package com.mediolio.mvc.model;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.fileupload.ImageUtil;
import com.mediolio.mvc.dao.ProjectDao;
import com.mediolio.viewer.BoxViewClient;
import com.mediolio.viewer.BoxViewException;
import com.mediolio.viewer.Document;
import com.mediolio.viewer.Session;
import com.mediolio.vo.ContentVO;
import com.mediolio.vo.HashtagVO;
import com.mediolio.vo.ProjectVO;
import com.mediolio.vo.SubcategoryVO;

@Controller
public class ProjectModel {
	@Autowired
	private ProjectDao pdao;
	
	private static BoxViewClient boxView;
	
	@RequestMapping(value="addProjectForm")
	public String addForm(Model model, HttpSession session){
		return "project/addProjectForm";
	}
	
	@RequestMapping(value="addProject")
	public String addProject(ProjectVO pvo, HttpSession session){
		// 프로젝트 업로드
		// 1. 새로운 프로젝트 추가
		// String[] orderArr, String hashtags, 
		pvo.setM_id((int)session.getAttribute("id"));
		int p_id = pdao.addProject(pvo); 
		
		// 2. 콘텐츠(이미지, 문서, 임베드 태그, 텍스트) 업로드 및 db에 등록
		List<MultipartFile> contents = pvo.getContents();
		String[] contentNames = new String[contents.size()];
		for(int i=0; i<contentNames.length; i++){
			contentNames[i] = contents.get(i).getOriginalFilename();
		}
		
		System.out.println("파일 수: "+contents.size());
//		for(int i=0; i<orderArr.length; i++){
//			System.out.println((i+1)+"번째 콘텐츠: "+orderArr[i]);
//			ContentVO covo = new ContentVO();
//
//			if(Arrays.asList(contentNames).contains(orderArr[i])){
//				// 2-1. 이미지, 문서 파일일 경우
//				int idx = Arrays.asList(contentNames).indexOf(orderArr[i]);
//				MultipartFile file = contents.get(idx); 
//				String newFileName = fileUpload(file, session); // 파일 업로드
//				String fileExt = newFileName.split("\\.")[1]; // 파일의 확장자
//				
//				String c_type = "document";
//				String[] imgExt = {"gif","png","jpg","jpeg"};
//				for(String e:imgExt){
//					if(fileExt.contains(e)){
//						c_type = "image";
//					}
//				}
//				
//				covo.setC_type(c_type); // 콘텐츠의 타입(image/document)
//				covo.setC_value(newFileName); // 콘텐츠의 파일 이름
//
//			} else {
//				// 2-2. 임베드 태그, 텍스트 db에 등록
//				covo.setC_type("html");
//				covo.setC_value(orderArr[i]);
//			}
//			
//			covo.setP_id(p_id); // 프로젝트 id
//			covo.setC_order(i); // 콘텐츠 순서
//			pdao.uploadContent(covo); // db에 콘텐츠 정보 업데이트
//			
//		}
//		
//		// 3. 해쉬태그 db에 등록
//		String[] hashtagArr = hashtags.split("/");
//		for(String tag:hashtagArr){
//			HashtagVO hvo = new HashtagVO();
//			hvo.setH_value(tag);
//			hvo.setP_id(p_id);
//			pdao.addHashtag(hvo);
//		}
//			
			if(null != contents & contents.size()>0){
				for(MultipartFile file:contents){
					if(file.getOriginalFilename() != ""){
						String newFileName = fileUpload(file, session); // 파일 업로드
						String fileExt = newFileName.split("\\.")[1]; // 파일의 확장자
						ContentVO covo = new ContentVO();
						
						String c_type = "document";
						String[] imgExt = {"gif","png","jpg","jpeg"};
						for(String e:imgExt){
							if(fileExt.contains(e)){
								c_type = "image";
							}
						}
						
						covo.setP_id(p_id); // 프로젝트 id
						covo.setC_type(c_type); // 콘텐츠의 타입(image/document)
						covo.setC_value(newFileName); // 콘텐츠의 파일 이름
//						covo.setC_order(Arrays.asList(orderArr).indexOf(file.getOriginalFilename())); // 콘텐츠 순서
						pdao.uploadContent(covo); // db에 콘텐츠 정보 업데이트
					}
				}
			}
				
		/*  
		 * c_id int(5) PRIMARY KEY auto_increment,
		 * p_id int(10),
		 * c_type VARCHAR(10),
		 * c_value VARCHAR(1000),
		 * c_order int(5)*/
		
		return "redirect:main";
	}
	
	@RequestMapping(value="showViewer")
	public void showViewer(ProjectVO pvo, HttpSession session, HttpServletResponse response) throws IOException{
		// doc, ppt, pdf 업로드 했을 때 뷰어 보여주기
		List<MultipartFile> contents = pvo.getContents();
		MultipartFile projectFile = contents.get(0);
		String[] imgExt = {"gif","png","jpg","jpeg"};
		for(MultipartFile file:contents){
			String ext = file.getOriginalFilename().split("\\.")[1];
			for(String img:imgExt){
				if(!(ext.contains(img))){
					projectFile = file;
				}
			}
		}
		
		String[] fileFullName = projectFile.getOriginalFilename().split("\\.");
		System.out.println(projectFile.getOriginalFilename());
		String fileName = fileFullName[0]; // 파일 이름
		String fileExt = fileFullName[1]; // 파일 확장자
		String newFileName = fileName+"_"+System.currentTimeMillis()+"."+fileExt;
		System.out.println("New File Name: "+newFileName); // 새로운 파일 이름(중복 방지)
		
		String realPath = session.getServletContext().getRealPath("/");
		StringBuffer path = new StringBuffer();
		path.append(realPath).append(newFileName);
		System.out.println("Upload Path: "+path.toString());
		
		File file = new File(path.toString());
		file.mkdirs();
		try {
			projectFile.transferTo(file);
		} catch (Exception e1) {
			e1.printStackTrace();
		} 
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", newFileName);
		params.put("nonSvg", true);
		
		try {
			boxView = new BoxViewClient("3e7kxpyozin7r0kbknmiwa2dmpcoyq3w");
			Document doc = boxView.upload(file, params);
			Session viewSession = doc.createSession();
			String viewUrl = viewSession.getViewUrl(); // 뷰어 url
			System.out.println("View Url: "+viewUrl);
			
			PrintWriter pw = response.getWriter();
			pw.write(viewUrl);
			pw.flush();
			pw.close();
			
		} catch (BoxViewException e) {
			System.out.println("Failed");
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping(value="subcategoryList")
	public void subcategoryList(int sc_parent, HttpServletResponse response) throws IOException{
		// 카테고리 선택 후 서브카테고리 추가 영역을 클릭했을 때
		// 해당하는 서브카테고리의 목록 출력
		List<SubcategoryVO> scList = pdao.subcategoryList(sc_parent);
		int[] scIds = new int[scList.size()];
		String[] scNames = new String[scList.size()];
		
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for(int i=0; i<scList.size(); i++){
			scIds[i] = scList.get(i).getSc_id();
			scNames[i] = scList.get(i).getSc_name();
			sb.append("\"<input type='checkbox' value="+scIds[i]+" data-labelauty='"+scNames[i]+"'/>");
			sb.append("<label class='label_category'>"+scNames[i]+"</label>");
			sb.append("\"");
			if(!(i == scList.size()-1)){
				sb.append(",");
			}
		}
		sb.append("]");
		
		PrintWriter pw = response.getWriter();
		pw.write(sb.toString());
		pw.flush();
		pw.close();
	}
	
	@RequestMapping(value="autocompleteTags")
	public void autocompleteTags(String h_value, HttpServletResponse response) throws IOException{
		// 태그 입력 시 자동 완성
		List<HashtagVO> tagList = pdao.autocompleteTags(h_value);
		int[] tagIds = new int[tagList.size()];
		String[] tagNames = new String[tagList.size()];
		
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for(int i=0; i<tagList.size(); i++){
			tagIds[i] = tagList.get(i).getH_id();
			tagNames[i] = tagList.get(i).getH_value();
			sb.append("\"");
			sb.append("<input type='hidden' name='h_id' value="+tagIds[i]+">");
			sb.append("<span name='h_value'>"+tagNames[i]+"</span>");
			sb.append("\"");
			if(!(i == tagList.size()-1)){
				sb.append(",");
			}
		}
		sb.append("]");
		
		PrintWriter pw = response.getWriter();
		pw.write(sb.toString());
		pw.flush();
		pw.close();
	}
	
	public String fileUpload(MultipartFile projectFile, HttpSession session){
		String[] fileFullName = projectFile.getOriginalFilename().split("\\.");
		System.out.println(projectFile.getOriginalFilename());
		String fileName = fileFullName[0]; // 파일 이름
		String fileExt = fileFullName[1].toLowerCase(); // 파일 확장자
		String newFileName = fileName+"_"+System.currentTimeMillis()+"."+fileExt;
		System.out.println("New File Name: "+newFileName); // 새로운 파일 이름(중복 방지)
		
		String realPath = session.getServletContext().getRealPath("/")+"upload\\";
		StringBuffer path = new StringBuffer();
		path.append(realPath).append(newFileName);
		System.out.println("Upload Path: "+path.toString());
		
		File file = new File(path.toString());
		file.mkdirs();
		try {
			projectFile.transferTo(file);
		} catch (Exception e1) {
			e1.printStackTrace();
		} 
		
		return newFileName;
	}

	
	//이미지 크롭 모달 및 파일업로드
	@RequestMapping(value = "imgCrop_modal")
	public String imgCrop_modal(Model model, @RequestParam("url") String url, HttpServletResponse response) throws IOException{
		model.addAttribute("imgUrl", url);
		return "project/cropModal";
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

