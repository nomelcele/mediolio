package com.mediolio.mvc.model;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.MemberActionDao;
import com.mediolio.vo.MemberVO;
import com.mediolio.vo.Member_actionVO;
import com.mediolio.vo.MessageVO;

/*
 * ***** 오지은 작성
 * ***** Member Action : 쪽지, 팔로우, 푸쉬알림
 */

@Controller
public class MemberActionModel {
	@Autowired
	private MemberActionDao maDao;
	
	
	//쪽지페이지 이동. '나'에게 온 메세지 리스트를 받아서 이동
	@RequestMapping("message")
	public String message(HttpSession session, Model model){		
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){
			model.addAttribute("list", maDao.getMsgListReceived(mev.getM_id()));
		}
		return "mypage.message";
	}
	
	//팔로우/팔로워 페이지 이동. 팔로우한 회원 목록과 팔로우/팔로워 숫자를 받아서 이동.
	@RequestMapping("follow")
	public String friend(HttpSession session, Model model){
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){
			model.addAttribute("list", maDao.getFollowingList(mev.getM_id()));
			model.addAttribute("cnt", maDao.friendCnt(mev.getM_id()));
		}
		return "mypage.friend";
	}
	
	//프로젝트를 "좋아요" 눌렀을 때
	@RequestMapping("projectLike")
	public ModelAndView projectLike(@RequestParam("p_id") String p_id, @RequestParam("act_to") String act_to, HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){		
			Member_actionVO maVo = new Member_actionVO();
			maVo.setAct_from(mev.getM_id());
			maVo.setAct_to(Integer.parseInt(act_to));
			maVo.setAct_what(Integer.parseInt(p_id));
			
			//좋아요 수 추가 & 현재 프로젝트의 좋아요 수 받아오기
			mav.addObject("likeNum", maDao.projectLike(maVo));
		}
		return mav;
	}
	
	//프로젝트 "좋아요" 취소
	@RequestMapping("projectLikeCancel")
	public ModelAndView projectLikeCancel(@RequestParam("p_id") String p_id, @RequestParam("act_to") String act_to, HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");

		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){
			Member_actionVO maVo = new Member_actionVO();
			maVo.setAct_from(mev.getM_id());
			maVo.setAct_to(Integer.parseInt(act_to));
			maVo.setAct_what(Integer.parseInt(p_id));
			
			maDao.projectLikeCancel(maVo);
		}
		
		return mav;
	}

	
	//쪽지보내기 모달 오픈
	@RequestMapping("msgModalOpen")
	public String msgModalOpen(Model model, @RequestParam("m_id") String m_id, @RequestParam("m_nickname") String m_name){
		model.addAttribute("m_id", m_id);
		model.addAttribute("m_name", m_name);
		return "modal.messageModal";
	}
	
	//쪽지 받을 대상 자동완성. 뷰에서 keyevent에 의해 발생
	@RequestMapping("autoCompleteWhoReceive")
	public ModelAndView autoCompleteWhoReceive(@RequestParam("m_name") String m_name){
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("list", maDao.autoCompleteWhoReceive(m_name));
		
		return mav;
	}
	
	//쪽지 보내기
	@RequestMapping("msgSend")
	public ModelAndView msgSend(MessageVO vo, HttpSession session){
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){
			vo.setMsg_from(mev.getM_id());
			maDao.msgSend(vo); //보낸 쪽지 디비에 등록
		}
		return new ModelAndView("jsonView");
	}
	
	//나에게 온 쪽지 받아오기
	@RequestMapping("getMsgListReceived")
	public ModelAndView getMsgListReceived(HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
		
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){
			mav.addObject("list", maDao.getMsgListReceived(mev.getM_id()));
		}
		return mav;
	}
	
	//내가 보낸 쪽지 받아오기
	@RequestMapping("getMsgListSent")
	public ModelAndView getMsgListSent(HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
		
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){
			mav.addObject("list", maDao.getMsgListSent(mev.getM_id()));
		}
		return mav;
	}
	
	//내가 보낸 메세지를 보낸메세지 목록에서 삭제했을 때
	@RequestMapping("deleteMsgSent")
	public ModelAndView deleteMsgSent(@RequestParam("msg_id") String msg_id){
		ModelAndView mav = new ModelAndView("jsonView");
		maDao.deleteMsgSent(Integer.parseInt(msg_id));
		return mav;
	}
	
	//내가 받은 메세지를 받은메세지 목록에서 삭제했을 때
	@RequestMapping("deleteMsgReceived")
	public ModelAndView deleteMsgReceived(@RequestParam("msg_id") String msg_id){
		ModelAndView mav = new ModelAndView("jsonView");
		maDao.deleteMsgReceived(Integer.parseInt(msg_id));
		return mav;
	}
	
	//내가 받은 쪽지 읽음으로 업데이트
	@RequestMapping("readMsgReceived")
	public ModelAndView readMsgReceived(@RequestParam("msg_id") String msg_id){
		ModelAndView mav = new ModelAndView("jsonView");
		maDao.readMsgReceived(Integer.parseInt(msg_id));
		return mav;
	}
	
	
	//팔로우하기
	@RequestMapping("followMember")
	public ModelAndView followMember(@RequestParam("m_id") String m_id, HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
		
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){
			Member_actionVO maVo = new Member_actionVO();
			
			maVo.setAct_from(mev.getM_id());
			maVo.setAct_to(Integer.parseInt(m_id));
			maDao.followMember(maVo);
		}
		return mav;
	}
	
	//팔로우 취소
	@RequestMapping("followCancel")
	public ModelAndView followCancel(@RequestParam("m_id") String m_id, HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
		
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){
			Member_actionVO maVo = new Member_actionVO();
			System.out.println("m_id to unfollow : " + m_id +", my m_id : " + mev.getM_id());
			
			maVo.setAct_from(mev.getM_id());
			maVo.setAct_to(Integer.parseInt(m_id));
			maDao.followCancel(maVo);;
		}
		return mav;
	}
	
	//팔로우 여부 체크
	@RequestMapping("followCheck")
	public ModelAndView followCheck(@RequestParam("m_id") String m_id, HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
		
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){			
			Member_actionVO maVo = new Member_actionVO();
			maVo.setAct_from(mev.getM_id());
			maVo.setAct_to(Integer.parseInt(m_id));
			
			//팔로우된 row가 있는지 체크
			int isFollow = maDao.followCheck(maVo);
			if(isFollow>0){
				//팔로우 됨
				mav.addObject("isFollowed", "y");
			}else{
				mav.addObject("isFollowed", "n");
			}
		}
		return mav;
	}
	
	//following list 받아오기
	@RequestMapping("getFollowingList")
	public ModelAndView getFollowingList(HttpSession session, Model model){
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){
			model.addAttribute("list", maDao.getFollowingList(mev.getM_id()));
		}
		return new ModelAndView("jsonView");
	}
	
	//follower list 받아오기
	@RequestMapping("getFollowerList")
	public ModelAndView getFollowerList(HttpSession session, Model model){
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){
			model.addAttribute("list", maDao.getFollowerList(mev.getM_id()));
		}
		return new ModelAndView("jsonView");
	}

}
