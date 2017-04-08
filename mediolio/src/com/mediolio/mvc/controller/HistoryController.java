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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.mediolio.mvc.dao.HistoryDao;
import com.mediolio.mvc.dao.ProjectDao;
import com.mediolio.vo.BranchVO;
import com.mediolio.vo.ClassVO;
import com.mediolio.vo.HistoryVO;
import com.mediolio.vo.MemberVO;

/* *****
 * ***** 모하람 작성
 * *****
 * */
@Controller
public class HistoryModel {
	@Autowired
	private HistoryDao htdao;
	@Autowired
	private ProjectDao pdao;
	
	// 새로운 히스토리 추가
	@RequestMapping(value="addHistory")
	public String addHistory(HistoryVO htvo,HttpSession session){
		htvo.setM_id(((MemberVO)session.getAttribute("mev")).getM_id());
		htdao.addHistory(htvo);
		return "redirect:gotoMyPage";
	}
	
	// 선택한 히스토리 삭제
	@RequestMapping(value="deleteHistory")
	public String deleteHistory(int ht_id){
		htdao.deleteHistory(ht_id);
		return "redirect:gotoMyPage";
	}
	
	// 선택한 히스토리에 브랜치 추가
	@RequestMapping(value="addBranch")
	public String addBranch(BranchVO brvo, HttpSession session){
		// 이미지 파일 업로드(최대 3개)
		List<MultipartFile> imgFiles = brvo.getImgFiles();
		if(imgFiles != null & imgFiles.size()>0){
			for(int i=0; i<imgFiles.size(); i++){
				MultipartFile multipartFile = imgFiles.get(i);
				String fileName = multipartFile.getOriginalFilename(); // 업로드할 파일의 이름
				
				if(fileName != ""){
					String[] fileFullName = multipartFile.getOriginalFilename().split("\\.");
					String fName = fileFullName[0]; // 파일 이름(확장자를 제외한 부분)
					String fileExt = fileFullName[1].toLowerCase(); // 파일 확장자
					String newFileName = fName+"_"+System.currentTimeMillis()+"."+fileExt;
					System.out.println("New File Name: "+newFileName); // 파일 이름 뒤에 현재 시간을 붙여서 새로운 파일 이름 생성(중복 방지)
				
					String realPath = session.getServletContext().getRealPath("/upload/"); 
					StringBuffer path = new StringBuffer();
					path.append(realPath).append("history/").append(newFileName); // 업로드할 경로
					System.out.println("File Upload Path: "+path);
					File file = new File(path.toString()); // 경로에 file 객체 생성
					file.mkdirs();
					try {
						multipartFile.transferTo(file); // 파일 업로드
						switch(i){
						// db에 저장할 이미지 파일 이름 VO 객체에 세팅
							case 0:
								brvo.setBr_img1(newFileName);
								break;
							case 1:
								brvo.setBr_img2(newFileName);
								break;
							case 2:
								brvo.setBr_img3(newFileName);
								break;
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		htdao.addBranch(brvo); // 브랜치 등록
		htdao.updateLastEdit(brvo.getHt_id()); // 현재 시간(히스토리가 가장 최근에 업데이트된 날짜) 등록
		return "redirect:gotoMyPage";
	}
	
	// 브랜치 삭제
	@RequestMapping(value="deleteBranch")
	public String deleteBranch(BranchVO brvo,String ht_title,Model model){
		htdao.deleteBranch(brvo.getBr_id());
		model.addAttribute("htId", brvo.getHt_id());
		model.addAttribute("htTitle", ht_title);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ht_id", String.valueOf(brvo.getHt_id()));
		map.put("type", "myPage");
		model.addAttribute("branchList", htdao.branchList(map));
		
		
		return "mypage.history";
	}
	
	// 목록에서 히스토리 선택 시 그 히스토리의 브랜치 표시
	@RequestMapping(value="historyDetail")
	public String historyDetail(HistoryVO htvo,String type,Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ht_id", String.valueOf(htvo.getHt_id()));
		map.put("type", type);
		model.addAttribute("branchList", htdao.branchList(map));
		
		model.addAttribute("htId", htvo.getHt_id());
		model.addAttribute("htTitle", htvo.getHt_title());
		return "mypage.history";
	}
	
	// 히스토리 등록 폼에서 관련 과목 입력 시 입력한 글자가 포함된 과목 이름 목록 가져옴
	@RequestMapping(value="autocompleteClass")
	public void autocompleteClass(String cl_name,HttpServletResponse response) throws IOException{
		List<ClassVO> classList = htdao.autocompleteClass(cl_name);
		int classNum = classList.size();
		int[] cl_ids = new int[classNum];
		String[] cl_names = new String[classNum];
		
		// JSON 형식으로 데이터 입력(과목 id, 과목 이름)
		// 클라이언트에서 데이터를 파싱하여 view에 html tag 동적으로 추가
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for(int i=0; i<classNum; i++){
			ClassVO cl = classList.get(i);
			cl_ids[i] = cl.getCl_id();
			cl_names[i] = cl.getCl_name();
			sb.append("\"");
			sb.append("<input type='hidden' class='classId' value="+cl_ids[i]+">");
			sb.append("<span class='className'>"+cl_names[i]+"</span>");
			sb.append("\"");
			if(i != classNum-1){
				sb.append(",");
			}
			
		}
		sb.append("]");
		
		// JSON 데이터 클라이언트로 전송
		PrintWriter pw = response.getWriter();
		pw.write(sb.toString());
		pw.flush();
		pw.close();
		
		
	}
	
	// 히스토리 공개 상태 변경(공개/비공개)
	@RequestMapping(value="changeHtPublic")
	public String changeHtPublic(HistoryVO htvo,Model model,HttpSession session){
		htdao.changeHtPublic(htvo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("m_id", String.valueOf(((MemberVO)(session.getAttribute("mev"))).getM_id()));
		map.put("type", "myPage");
		
		model.addAttribute("htList", htdao.historyList(map));
		return "mypage.historyList";
	}
	
	// 유저(접속한 사용자 외의 회원)의 히스토리, 게시물(프로젝트,과제) 열람
	@RequestMapping(value="userHistory")
	public String userHistory(int m_id, Model model){
		// 전체 히스토리 리스트
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("m_id", String.valueOf(m_id));
		map.put("type", "userPage");
		List<HistoryVO> htList = htdao.historyList(map);
		model.addAttribute("htList", htList);
		// 가장 최근에 업데이트 된 히스토리의 브랜치들 불러오기
		if(!htList.isEmpty()){
			HistoryVO recentHt = htList.get(0);
			model.addAttribute("recentHtId", recentHt.getHt_id());
			model.addAttribute("recentHtTitle", recentHt.getHt_title());
			
			Map<String, Object> map2 = new HashMap<String, Object>();
			map2.put("ht_id", String.valueOf(recentHt.getHt_id()));
			map2.put("type", "userPage");
			model.addAttribute("branches",htdao.branchList(map2));
		}
				
		// 유저의 게시물
		model.addAttribute("myProjects",pdao.userProject(m_id));
		model.addAttribute("type","userPage");
				
		return "mypage/mypage";
	}
}
