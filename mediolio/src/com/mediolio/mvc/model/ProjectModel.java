package com.mediolio.mvc.model;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.BoxView;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

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
	public String addForm(){
		return "project/addProjectForm";
	}
	
	@RequestMapping(value="addProject")
	public String addProject(ProjectVO pvo, HttpSession session){
		// 프로젝트 업로드
		List<MultipartFile> contents = pvo.getContents();
		System.out.println("파일 수: "+contents.size());
		if(null != contents & contents.size()>0){
			for(MultipartFile file:contents){
				if(file.getOriginalFilename() != ""){
					String newFileName = fileUpload(file, session); // 파일 업로드
					String fileExt = newFileName.split("\\.")[1]; // 파일의 확장자
					ContentVO covo = new ContentVO();
					covo.setP_id(1); // 프로젝트 id
					
					String c_type = "document";
					String[] imgExt = {"gif","png","jpg","jpeg"};
					for(String e:imgExt){
						if(fileExt.contains(e)){
							c_type = "image";
						}
					}
					covo.setC_type(c_type); // 콘텐츠의 타입(image/document)
					covo.setC_value(newFileName); // 콘텐츠의 파일 이름
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
		MultipartFile projectFile = pvo.getContents().get(0);
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


}

