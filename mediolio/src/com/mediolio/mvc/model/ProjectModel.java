package com.mediolio.mvc.model;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

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
import com.mediolio.mvc.dao.MainDao;
import com.mediolio.mvc.dao.ProjectDao;
import com.mediolio.vo.ContentVO;
import com.mediolio.vo.HashtagVO;
import com.mediolio.vo.MemberVO;
import com.mediolio.vo.ProjectVO;
import com.mediolio.vo.TeamMemberVO;

/* *****
 * ***** 모하람 + 오지은 작성
 * *****
 * */
@Controller
public class ProjectModel {
	@Autowired
	private ProjectDao pdao;
	@Autowired
	private MainDao mdao;
	
	// 모하람 작성 - 게시물 작성 페이지로 이동
	@RequestMapping(value="addProjectForm")
	public String addForm(Model model, HttpSession session){
		return "project/addProjectForm";
	}
	
	// 모하람 작성 - 새로운 게시물(프로젝트/과제) 작성
	@RequestMapping(value="addProject")
	public String addProject(ProjectVO pvo, TeamMemberVO tmvo, String[] orderArr, HttpSession session, Model model){
		
		// 1. 새로운 게시물 추가
		int m_id = ((MemberVO)session.getAttribute("mev")).getM_id(); // 현재 로그인한 유저의 회원 번호
		pvo.setM_id(m_id);
		int p_id = pdao.addProject(pvo); // 새로운 게시물 등록 후 그 게시물의 id 리턴
		
		// 2. 콘텐츠(이미지, 문서, 임베드 태그, 텍스트) 업로드 및 db에 등록
		List<MultipartFile> contents = pvo.getContents(); // 업로드할 파일(이미지, 문서)들의 리스트
		String[] contentNames; // 파일의 이름을 저장할 배열
		if(contents != null){
			contentNames = new String[contents.size()];
			for(int i=0; i<contentNames.length; i++){
				contentNames[i] = contents.get(i).getOriginalFilename(); // 배열에 파일 이름 저장
				System.out.println("contentNames "+i+"번째 : " + contentNames[i]);
			}
			
			for(int i=0; i<orderArr.length; i++){
				System.out.println("orderArr" + (i+1)+"번째 콘텐츠: "+orderArr[i]);
				ContentVO covo = new ContentVO();

				String docRealName = "default";
				if(orderArr[i].contains(".") && orderArr[i].contains("_")){
					docRealName = orderArr[i].substring(0,orderArr[i].lastIndexOf("_"))+"."+ orderArr[i].split("\\.")[1];
				}
					
				System.out.println("docRealName: "+docRealName);
				
				int idx = 0;
				MultipartFile file = null;
				
				if(Arrays.asList(contentNames).contains(orderArr[i]) || Arrays.asList(contentNames).contains(docRealName)){
					// 2-1. 이미지, 문서 파일일 경우
					if(Arrays.asList(contentNames).contains(orderArr[i])){
						idx = Arrays.asList(contentNames).indexOf(orderArr[i]);
					} else if(Arrays.asList(contentNames).contains(docRealName)){
						idx = Arrays.asList(contentNames).indexOf(docRealName);
					}
					
					file = contents.get(idx);
					
					String fileExt = file.getOriginalFilename().split("\\.")[1]; // 파일의 확장자
					
					// c_type: 콘텐츠의 타입(document: 문서, image: 이미지, html: embed 태그,텍스트) 지정
					// db에 저장할 때 구분하기 위해서 타입 지정
					String c_type = "document";
					String[] imgExt = {"gif","png","jpg","jpeg"};
					for(String e:imgExt){
						if(fileExt.toLowerCase().contains(e)){
							c_type = "image"; 
						}
					}
					
					if(c_type.equals("image")){
						// 이미지 파일인 경우 업로드
						String newFileName = fileUpload(file, session); // 파일 업로드
						covo.setC_value(newFileName); // 콘텐츠의 파일 이름
					} else {
						// 문서 파일의 경우, 게시물 작성 단계에서 미리보기로 뷰어 보여줄 때(요청명-showViewer2) 
						// 이미 업로드를 했기 때문에 이 단계에서는 db에 파일 이름만 넣어주면 됨
						// orderArr 배열에 저장된 이름으로 저장('파일의 최초 이름_업로드 당시의 시간'형식의 이름)
						System.out.println("문서파일 디비에 넣기: "+orderArr[i]);
						covo.setC_value(orderArr[i]);
					}
					
					covo.setC_type(c_type); 
					

				} else {
					// 2-2. embed 태그, 텍스트 db에 등록
					covo.setC_type("html");
					covo.setC_value(orderArr[i].replace("contenteditable=\"true\"", ""));
					
				}
				
				covo.setP_id(p_id); // 프로젝트 id
				covo.setC_order(i); // 콘텐츠 순서
				pdao.uploadContent(covo); // db에 콘텐츠 정보 업데이트
				
			}//for문 끝
		} else {
			// 파일을 업로드하지 않았을 경우
			for(int i=0; i<orderArr.length; i++){
				ContentVO covo = new ContentVO();
				covo.setC_type("html");
				covo.setC_value(orderArr[i]);
				covo.setP_id(p_id);
				covo.setC_order(i);
				pdao.uploadContent(covo);
			}
		}
		

		
		// 3. 게시물의 해쉬태그 db에 등록
		String[] hashtagArr = pvo.getHashtags().split("/");
		for(String tag:hashtagArr){
			HashtagVO hvo = new HashtagVO();
			hvo.setH_value(tag);
			hvo.setP_id(p_id);
			pdao.addHashtag(hvo);
		}
			
		List<TeamMemberVO> tmList = tmvo.getTmList();
		// 4. 프로젝트 팀원 정보 db에 업데이트
		for(TeamMemberVO vo:tmList){
			vo.setP_id(p_id);
			pdao.addTeamMember(vo);
		}
				
		// 새로 등록된 게시물의 상세 보기 페이지로 바로 이동
		return "redirect:projectView?m_id="+m_id+"&p_id="+p_id;
	}
	
	// 게시물 작성 페이지에서 문서 파일 업로드 했을 때, 뷰어(미리보기) 보여주기
	@RequestMapping(value="showViewer2")
	public void showViewer2(ProjectVO pvo, HttpSession session, HttpServletResponse response) throws IOException{
		MultipartFile docFile = pvo.getDoc();
		String newFileName = fileUpload(docFile, session); // 파일 서버에 업로드
		PrintWriter pw = response.getWriter();
		pw.write(newFileName); // 새로운 파일 이름(중복 방지를 위해 새롭게 만든 파일 이름)을 클라이언트에 전송
		pw.flush();
		pw.close();
	}
	
	// 해쉬태그 입력 시 자동 완성
	@RequestMapping(value="autocompleteTags")
	public void autocompleteTags(String h_value, HttpServletResponse response) throws IOException{
		List<HashtagVO> tagList = pdao.autocompleteTags(h_value); // 사용자가 입력한 글자(h_value)가 포함된 해쉬태그 목록 리턴
		int[] tagIds = new int[tagList.size()];
		String[] tagNames = new String[tagList.size()];
		
		// JSON 형식으로 데이터 입력(해쉬태그 id, 해쉬태그 이름)
		// 클라이언트에서 데이터를 파싱하여 view에 html tag 동적으로 추가
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
		
		// JSON 데이터 클라이언트로 전송
		PrintWriter pw = response.getWriter();
		pw.write(sb.toString());
		pw.flush();
		pw.close();
	}
	
	// 파일 업로드
	public String fileUpload(MultipartFile projectFile, HttpSession session){
		String[] fileFullName = projectFile.getOriginalFilename().split("\\.");
		System.out.println(projectFile.getOriginalFilename());
		String fileName = fileFullName[0]; // 파일 이름(확장자를 제외한 부분)
		String fileExt = fileFullName[1].toLowerCase(); // 파일 확장자
		String newFileName = fileName+"_"+System.currentTimeMillis()+"."+fileExt; // 중복 방지를 위해 파일 이름에 현재 시간을 붙여서 새로운 이름 생성
		System.out.println("New File Name: "+newFileName); 
		
		String realPath = session.getServletContext().getRealPath("/upload/");
		StringBuffer path = new StringBuffer();
		
		String type = "docs";
		String[] imgExt = {"gif","png","jpg","jpeg"};
		for(String img:imgExt){ // 확장자를 확인하여 문서/이미지 파일 구분
			if(fileExt.toLowerCase().contains(img)){
				type = "img";
				break;
			}
		}
		
		// 문서 파일은 docs 폴더에, 이미지 파일은 img 폴더에 저장하기 위해 업로드 경로 설정
		if(type.equals("docs")){ 
			path.append(realPath).append("docs/").append(newFileName);
		} else {
			path.append(realPath).append("img/").append(newFileName);
		}
		
		System.out.println("Upload Path: "+path.toString());
		
		File file = new File(path.toString());
		file.mkdirs();
		try {
			projectFile.transferTo(file); // 파일 업로드
		} catch (Exception e1) {
			e1.printStackTrace();
		} 
		
		return newFileName;
	}

	
	
	/* ***** 오지은 작성         *************
	 * ***** 이미지 크롭 관련  *************
	 * ***** 
	 * */
	//이미지 크롭 모달 열기
	@RequestMapping(value = "imgCrop_modal")
	public String imgCrop_modal(Model model, @RequestParam("url") String url) throws IOException{
		model.addAttribute("imgUrl", url);
		return "modal.cropModal";
	}
	
	//크롭한 이미지 파일화하여 폴더에 업로드, 파일명 리턴받는 함수
	@RequestMapping(value = "cropImage", method = RequestMethod.POST)
	public ModelAndView cropImage( MultipartHttpServletRequest  request, HttpSession session) throws IOException{
		ModelAndView mav = new ModelAndView("jsonView");
		
		//뷰에서 넘어온 파일객체 받아 가공
		MultipartFile multipartFile = request.getFile("coverImg");
		String fileFullName = multipartFile.getOriginalFilename(); //파일명.확장자명 받기
		String fileName = fileFullName.substring(0, fileFullName.lastIndexOf(".")); //파일 명만 split
		String fileType = fileFullName.substring(fileFullName.lastIndexOf(".")+1, fileFullName.length()); //확장자 명만 split
		System.out.println("fileName : " + fileName + ", " + "fileType : " + fileType);
		
		//경로 설정
		String saveDir = new HttpServletRequestWrapper(request).getSession().getServletContext().getRealPath("/resources/images/projectCover");
		System.out.println(saveDir);
		
		//크롭할 영역 받아오기
		int x=(int) Float.parseFloat(request.getParameter("x"));
        int y=(int) Float.parseFloat(request.getParameter("y"));
        int w=(int) Float.parseFloat(request.getParameter("w"))-4;
        int h=(int) Float.parseFloat(request.getParameter("h"))-4;

		try {
			//multipartFile 형식을 BufferedImage로 변환 (이미지를 크롭하려면 BufferedImage 형식이 필요)
			//multipartFile->Image->BufferedImage (ImageUtil.java에 있는 함수 사용)
			Image originalImage = ImageUtil.get_imageObj(multipartFile);
			BufferedImage buffered_originalImg = ImageUtil.toBufferedImage(originalImage);
			
			//원본 이미지에서 crop 이미지 생성 과정
			BufferedImage SubImage = buffered_originalImg.getSubimage(x, y, w, h);
			
			//이름 재설정(중복방지)
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
			String cropReplaceName = "crop_"+fileName+"_"+formatter.format(new Date()) +"."+ fileType;
			
			//bufferedImage -> InputStream (이미지를 파일에 쓰기 위한 형식)
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ImageIO.write(SubImage, fileType, baos);
			InputStream is = new ByteArrayInputStream(baos.toByteArray());
			
			//파일쓰기
			ImageUtil.fileUpload(is, saveDir, cropReplaceName);
			
			//새로 지정된 파일명 리턴
			mav.addObject("result", cropReplaceName);
		} catch (IOException e) {
			e.printStackTrace();
			mav.addObject("result", "fail");
		}	
		return mav;
	}
	//------------ 오지은 작성 부분 끝 ---------------------------------------------------
	
	
	// 팀원 정보 입력 시 이름 자동 완성
	@RequestMapping(value="autocompleteMember")
	public void autocompleteMember(String m_name,HttpServletResponse response) throws IOException{
		List<MemberVO> memList = pdao.autocompleteMember(m_name);
		int memNum = memList.size();
		int[] m_ids = new int[memNum];
		String[] m_names = new String[memNum];
		String[] m_studentIDs = new String[memNum];
		
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for(int i=0; i<memNum; i++){
			MemberVO m = memList.get(i);
			m_ids[i] = m.getM_id();
			m_names[i] = m.getM_name();
			System.out.println("학생 이름: "+m_names[i]);
			m_studentIDs[i] = m.getM_studentID();
			sb.append("\"");
			sb.append("<input type='hidden' class='memId' value="+m_ids[i]+">");
			sb.append("<span class='memName'>"+m_studentIDs[i]+" "+m_names[i]+"</span>");
			sb.append("\"");
			if(i != memNum-1){
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

