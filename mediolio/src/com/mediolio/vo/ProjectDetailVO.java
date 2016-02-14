package com.mediolio.vo;

public class ProjectDetailVO {
	private int p_id, m_id, cate_id, p_viewnum, p_likenum, p_replynum, follow_or_not, like_or_not;
	private String m_studentID, m_nickname, m_introduce, m_interestingPart, sc_id, cate_name, p_title, p_date;
	
	
	public int getFollow_or_not() {
		return follow_or_not;
	}
	public void setFollow_or_not(int follow_or_not) {
		this.follow_or_not = follow_or_not;
	}
	public int getLike_or_not() {
		return like_or_not;
	}
	public void setLike_or_not(int like_or_not) {
		this.like_or_not = like_or_not;
	}
	public String getM_interestingPart() {
		return m_interestingPart;
	}
	public void setM_interestingPart(String m_interestingPart) {
		this.m_interestingPart = m_interestingPart;
	}
	public int getP_id() {
		return p_id;
	}
	public void setP_id(int p_id) {
		this.p_id = p_id;
	}
	public int getM_id() {
		return m_id;
	}
	public void setM_id(int m_id) {
		this.m_id = m_id;
	}
	public int getCate_id() {
		return cate_id;
	}
	public void setCate_id(int cate_id) {
		this.cate_id = cate_id;
	}
	public int getP_viewnum() {
		return p_viewnum;
	}
	public void setP_viewnum(int p_viewnum) {
		this.p_viewnum = p_viewnum;
	}
	public int getP_likenum() {
		return p_likenum;
	}
	public void setP_likenum(int p_likenum) {
		this.p_likenum = p_likenum;
	}
	public int getP_replynum() {
		return p_replynum;
	}
	public void setP_replynum(int p_replynum) {
		this.p_replynum = p_replynum;
	}
	public String getM_studentID() {
		return m_studentID;
	}
	public void setM_studentID(String m_studentID) {
		this.m_studentID = m_studentID;
	}
	public String getM_nickname() {
		return m_nickname;
	}
	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}
	public String getM_introduce() {
		return m_introduce;
	}
	public void setM_introduce(String m_introduce) {
		this.m_introduce = m_introduce;
	}
	public String getSc_id() {
		return sc_id;
	}
	public void setSc_id(String sc_id) {
		this.sc_id = sc_id;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	public String getP_title() {
		return p_title;
	}
	public void setP_title(String p_title) {
		this.p_title = p_title;
	}
	public String getP_date() {
		return p_date;
	}
	public void setP_date(String p_date) {
		this.p_date = p_date;
	}
	
	
}
