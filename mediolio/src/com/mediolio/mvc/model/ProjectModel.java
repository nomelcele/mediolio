package com.mediolio.mvc.model;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public String addProject(){
		return "project/addProject";
	}
	
	@RequestMapping(value="showViewer")
	public void showViewer(MultipartFile projectFile, HttpSession session, HttpServletResponse response) throws IOException{
		// doc, ppt, pdf 업로드 했을 때 뷰어 보여주기
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

}
