package com.mediolio.mvc.model;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.mediolio.mvc.dao.HistoryDao;
import com.mediolio.vo.BranchVO;
import com.mediolio.vo.HistoryVO;
import com.mediolio.vo.MemberVO;

@Controller
public class HistoryModel {
	@Autowired
	private HistoryDao htdao;
	
	@RequestMapping(value="addHistory")
	public String addHistory(HistoryVO htvo,HttpSession session){
		// 새로운 히스토리 추가
		htvo.setM_id(((MemberVO)session.getAttribute("mev")).getM_id());
		htdao.addHistory(htvo);
		return "redirect:gotoMyPage";
	}
	
	@RequestMapping(value="deleteHistory")
	public String deleteHistory(int ht_id){
		// 히스토리 삭제
		htdao.deleteHistory(ht_id);
		return "redirect:gotoMyPage";
	}
	
	@RequestMapping(value="addBranch")
	public String addBranch(BranchVO brvo, HttpSession session){
		// 히스토리에 브랜치 추가
		// 이미지 파일 업로드
		List<MultipartFile> imgFiles = brvo.getImgFiles();
		if(imgFiles != null & imgFiles.size()>0){
			for(int i=0; i<imgFiles.size(); i++){
				MultipartFile multipartFile = imgFiles.get(i);
				String fileName = multipartFile.getOriginalFilename();
				if(fileName != ""){
					String realPath = session.getServletContext().getRealPath("/"); // 업로드 경로
					StringBuffer path = new StringBuffer();
					path.append(realPath).append("upload\\history\\").append(fileName);
					System.out.println("File Upload Path: "+path);
					File file = new File(path.toString());
					file.mkdirs();
					try {
						multipartFile.transferTo(file); // 파일 업로드
						switch(i){
						// db에 저장할 이미지 파일 이름 VO 객체에 세팅
							case 0:
								brvo.setBr_img1(fileName);
								break;
							case 1:
								brvo.setBr_img2(fileName);
								break;
							case 2:
								brvo.setBr_img3(fileName);
								break;
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		htdao.addBranch(brvo);
		htdao.updateLastEdit(brvo.getHt_id());
		return "redirect:gotoMyPage";
	}
	
	@RequestMapping(value="deleteBranch")
	public String deleteBranch(BranchVO brvo){
		// 브랜치 삭제
		htdao.deleteBranch(brvo.getBr_id());
		htdao.updateLastEdit(brvo.getHt_id());
		return "redirect:gotoMyPage";
	}
	
	@RequestMapping(value="historyDetail")
	public String historyDetail(HistoryVO htvo,Model model){
		// 목록에서 히스토리 선택 시 그 히스토리의 브랜치 표시
		List<BranchVO> list = htdao.branchList(htvo.getHt_id());
		for(BranchVO e:list){
			System.out.println("뭐가 문제임"+e.getBr_title());
		}
		model.addAttribute("branchList", list);
		model.addAttribute("htId", htvo.getHt_id());
		model.addAttribute("htTitle", htvo.getHt_title());
		return "mypage.history";
	}
}
